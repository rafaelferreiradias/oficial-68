export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instanciate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "12.2.3 (519615d)"
  }
  public: {
    Tables: {
      avaliacoes_semanais: {
        Row: {
          created_at: string
          dias_completos: number | null
          id: string
          observacoes: string | null
          pontuacao_media: number | null
          semana_inicio: string
          total_pontos: number | null
          user_id: string
        }
        Insert: {
          created_at?: string
          dias_completos?: number | null
          id?: string
          observacoes?: string | null
          pontuacao_media?: number | null
          semana_inicio: string
          total_pontos?: number | null
          user_id: string
        }
        Update: {
          created_at?: string
          dias_completos?: number | null
          id?: string
          observacoes?: string | null
          pontuacao_media?: number | null
          semana_inicio?: string
          total_pontos?: number | null
          user_id?: string
        }
        Relationships: []
      }
      dados_fisicos: {
        Row: {
          agua_corporal_pct: number | null
          circunferencia_abdominal_cm: number | null
          created_at: string
          data_medicao: string
          gordura_corporal_pct: number | null
          gordura_visceral: number | null
          id: string
          imc: number | null
          massa_muscular_kg: number | null
          origem_medicao: string | null
          peso_kg: number
          taxa_metabolica_basal: number | null
          user_id: string
        }
        Insert: {
          agua_corporal_pct?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string
          data_medicao?: string
          gordura_corporal_pct?: number | null
          gordura_visceral?: number | null
          id?: string
          imc?: number | null
          massa_muscular_kg?: number | null
          origem_medicao?: string | null
          peso_kg: number
          taxa_metabolica_basal?: number | null
          user_id: string
        }
        Update: {
          agua_corporal_pct?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string
          data_medicao?: string
          gordura_corporal_pct?: number | null
          gordura_visceral?: number | null
          id?: string
          imc?: number | null
          massa_muscular_kg?: number | null
          origem_medicao?: string | null
          peso_kg?: number
          taxa_metabolica_basal?: number | null
          user_id?: string
        }
        Relationships: []
      }
      dados_saude: {
        Row: {
          altura_cm: number | null
          circunferencia_abdominal_cm: number | null
          created_at: string
          data_atualizacao: string
          id: string
          imc: number | null
          meta_peso_kg: number | null
          peso_atual_kg: number | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string
          data_atualizacao?: string
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          peso_atual_kg?: number | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string
          data_atualizacao?: string
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          peso_atual_kg?: number | null
          user_id?: string
        }
        Relationships: []
      }
      missoes_diarias: {
        Row: {
          created_at: string
          data_missao: string
          id: string
          missoes_completas: number | null
          pontuacao_total: number | null
          total_missoes: number | null
          updated_at: string
          user_id: string
        }
        Insert: {
          created_at?: string
          data_missao: string
          id?: string
          missoes_completas?: number | null
          pontuacao_total?: number | null
          total_missoes?: number | null
          updated_at?: string
          user_id: string
        }
        Update: {
          created_at?: string
          data_missao?: string
          id?: string
          missoes_completas?: number | null
          pontuacao_total?: number | null
          total_missoes?: number | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      pontuacoes: {
        Row: {
          categoria: string | null
          created_at: string
          data_pontuacao: string
          descricao: string | null
          id: string
          pontos: number
          user_id: string
        }
        Insert: {
          categoria?: string | null
          created_at?: string
          data_pontuacao: string
          descricao?: string | null
          id?: string
          pontos?: number
          user_id: string
        }
        Update: {
          categoria?: string | null
          created_at?: string
          data_pontuacao?: string
          descricao?: string | null
          id?: string
          pontos?: number
          user_id?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          altura_cm: number | null
          celular: string | null
          created_at: string
          data_nascimento: string | null
          full_name: string | null
          id: string
          sexo: string | null
          updated_at: string
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          celular?: string | null
          created_at?: string
          data_nascimento?: string | null
          full_name?: string | null
          id?: string
          sexo?: string | null
          updated_at?: string
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          celular?: string | null
          created_at?: string
          data_nascimento?: string | null
          full_name?: string | null
          id?: string
          sexo?: string | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
