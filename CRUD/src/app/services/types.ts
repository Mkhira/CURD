

export interface ServiceResponse<T = any> {
    data?: T
    message?: string
    error?: ErrorSchema
  }
  
  export interface ErrorSchema {
    message?: string
    path?: string
    code?: number
  }