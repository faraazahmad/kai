export interface NoteType {
  id: number
  content: string
  user_id: string
  submission_id: string
}

export type NoteFormType = Omit<NoteType, 'id'>
