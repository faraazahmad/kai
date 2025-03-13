export interface SubmissionType {
  id: number
  title: string
  url: string
  user_id: string
  content: string
  status: string
  submission_type: string
}

export type SubmissionFormType = Omit<SubmissionType, 'id'>
