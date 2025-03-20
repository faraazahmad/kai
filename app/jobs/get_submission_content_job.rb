class GetSubmissionContentJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission = Submission.find(submission_id)
    submission.update(status: 'Processing')

    ai_service = AiService.new
    url = submission.url
    title = submission.title

    if match_pdf_url(url)
      content = ai_service.get_pdf_highlights(title, url)
      submission.content = content
      submission.submission_type = 'pdf'
    elsif match_youtube_url(url)
      content = ai_service.get_video_transcript(url)
      submission.content = content
      submission.submission_type = 'youtube'
    end

    submission.status = 'Processed'
    submission.save()
  end

  private

  def match_pdf_url(url)
    regex = %r{https?://[^\s]+\.pdf$}
    regex.match(url)
  end

  def match_youtube_url(url)
    regex = /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
    regex.match(url)
  end
end
