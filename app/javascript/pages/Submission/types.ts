export interface SubmissionType {
  id: number
  title: string
  url: string
  user_id: string
  content: string
}

export type SubmissionFormType = Omit<SubmissionType, 'id'>
