export interface SubmissionType {
  id: number
  title: string
  url: string
  user_id: string
  content: string
  status: string
  submission_type: string
  updated_at_ago: string
  tags: Object[]
}

export type SubmissionFormType = Omit<SubmissionType, 'id'>
