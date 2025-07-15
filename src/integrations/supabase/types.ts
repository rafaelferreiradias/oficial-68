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
      achievements: {
        Row: {
          condition_type: string | null
          condition_value: Json | null
          created_at: string | null
          description: string | null
          icon: string | null
          id: string
          title: string
        }
        Insert: {
          condition_type?: string | null
          condition_value?: Json | null
          created_at?: string | null
          description?: string | null
          icon?: string | null
          id?: string
          title: string
        }
        Update: {
          condition_type?: string | null
          condition_value?: Json | null
          created_at?: string | null
          description?: string | null
          icon?: string | null
          id?: string
          title?: string
        }
        Relationships: []
      }
      challenges: {
        Row: {
          category: Database["public"]["Enums"]["challenge_category"] | null
          created_at: string | null
          description: string | null
          duration_days: number | null
          icon: string | null
          id: string
          is_active: boolean | null
          level: Database["public"]["Enums"]["challenge_level"] | null
          points: number | null
          title: string
          updated_at: string | null
        }
        Insert: {
          category?: Database["public"]["Enums"]["challenge_category"] | null
          created_at?: string | null
          description?: string | null
          duration_days?: number | null
          icon?: string | null
          id?: string
          is_active?: boolean | null
          level?: Database["public"]["Enums"]["challenge_level"] | null
          points?: number | null
          title: string
          updated_at?: string | null
        }
        Update: {
          category?: Database["public"]["Enums"]["challenge_category"] | null
          created_at?: string | null
          description?: string | null
          duration_days?: number | null
          icon?: string | null
          id?: string
          is_active?: boolean | null
          level?: Database["public"]["Enums"]["challenge_level"] | null
          points?: number | null
          title?: string
          updated_at?: string | null
        }
        Relationships: []
      }
      courses: {
        Row: {
          category: string | null
          created_at: string | null
          description: string | null
          duration_minutes: number | null
          id: string
          is_premium: boolean | null
          thumbnail: string | null
          title: string
          updated_at: string | null
          video_url: string | null
        }
        Insert: {
          category?: string | null
          created_at?: string | null
          description?: string | null
          duration_minutes?: number | null
          id?: string
          is_premium?: boolean | null
          thumbnail?: string | null
          title: string
          updated_at?: string | null
          video_url?: string | null
        }
        Update: {
          category?: string | null
          created_at?: string | null
          description?: string | null
          duration_minutes?: number | null
          id?: string
          is_premium?: boolean | null
          thumbnail?: string | null
          title?: string
          updated_at?: string | null
          video_url?: string | null
        }
        Relationships: []
      }
      dados_fisicos_usuario: {
        Row: {
          altura_cm: number | null
          categoria_imc: string | null
          circunferencia_abdominal_cm: number | null
          created_at: string | null
          data_nascimento: string | null
          id: string
          imc: number | null
          meta_peso_kg: number | null
          nome_completo: string | null
          peso_atual_kg: number | null
          risco_cardiometabolico: string | null
          sexo: string | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          categoria_imc?: string | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_nascimento?: string | null
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          nome_completo?: string | null
          peso_atual_kg?: number | null
          risco_cardiometabolico?: string | null
          sexo?: string | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          categoria_imc?: string | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_nascimento?: string | null
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          nome_completo?: string | null
          peso_atual_kg?: number | null
          risco_cardiometabolico?: string | null
          sexo?: string | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "dados_fisicos_usuario_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      dados_saude_usuario: {
        Row: {
          altura_cm: number | null
          circunferencia_abdominal_cm: number | null
          created_at: string | null
          data_atualizacao: string | null
          id: string
          imc: number | null
          meta_peso_kg: number | null
          peso_atual_kg: number | null
          progresso_percentual: number | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_atualizacao?: string | null
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          peso_atual_kg?: number | null
          progresso_percentual?: number | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_atualizacao?: string | null
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          peso_atual_kg?: number | null
          progresso_percentual?: number | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "dados_saude_usuario_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      daily_missions: {
        Row: {
          completed: boolean | null
          completed_at: string | null
          created_at: string | null
          id: string
          mission_date: string
          mission_id: string
          points_earned: number | null
          user_id: string
        }
        Insert: {
          completed?: boolean | null
          completed_at?: string | null
          created_at?: string | null
          id?: string
          mission_date: string
          mission_id: string
          points_earned?: number | null
          user_id: string
        }
        Update: {
          completed?: boolean | null
          completed_at?: string | null
          created_at?: string | null
          id?: string
          mission_date?: string
          mission_id?: string
          points_earned?: number | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "daily_missions_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      historico_medidas: {
        Row: {
          altura_cm: number | null
          circunferencia_abdominal_cm: number | null
          created_at: string | null
          data_medicao: string | null
          id: string
          imc: number | null
          peso_kg: number | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_medicao?: string | null
          id?: string
          imc?: number | null
          peso_kg?: number | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_medicao?: string | null
          id?: string
          imc?: number | null
          peso_kg?: number | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "historico_medidas_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      informacoes_fisicas: {
        Row: {
          altura_cm: number | null
          circunferencia_abdominal_cm: number | null
          created_at: string | null
          data_nascimento: string | null
          id: string
          imc: number | null
          meta_peso_kg: number | null
          peso_atual_kg: number | null
          sexo: string | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_nascimento?: string | null
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          peso_atual_kg?: number | null
          sexo?: string | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          circunferencia_abdominal_cm?: number | null
          created_at?: string | null
          data_nascimento?: string | null
          id?: string
          imc?: number | null
          meta_peso_kg?: number | null
          peso_atual_kg?: number | null
          sexo?: string | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "informacoes_fisicas_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      missao_dia: {
        Row: {
          agua_litros: string | null
          atividade_fisica: boolean | null
          concluido: boolean | null
          created_at: string | null
          data: string
          energia_ao_acordar: number | null
          estresse_nivel: number | null
          fome_emocional: boolean | null
          gratidao: string | null
          id: string
          intencao_para_amanha: string | null
          liquido_ao_acordar: string | null
          nota_dia: number | null
          pequena_vitoria: string | null
          pratica_conexao: string | null
          sono_horas: number | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          agua_litros?: string | null
          atividade_fisica?: boolean | null
          concluido?: boolean | null
          created_at?: string | null
          data: string
          energia_ao_acordar?: number | null
          estresse_nivel?: number | null
          fome_emocional?: boolean | null
          gratidao?: string | null
          id?: string
          intencao_para_amanha?: string | null
          liquido_ao_acordar?: string | null
          nota_dia?: number | null
          pequena_vitoria?: string | null
          pratica_conexao?: string | null
          sono_horas?: number | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          agua_litros?: string | null
          atividade_fisica?: boolean | null
          concluido?: boolean | null
          created_at?: string | null
          data?: string
          energia_ao_acordar?: number | null
          estresse_nivel?: number | null
          fome_emocional?: boolean | null
          gratidao?: string | null
          id?: string
          intencao_para_amanha?: string | null
          liquido_ao_acordar?: string | null
          nota_dia?: number | null
          pequena_vitoria?: string | null
          pratica_conexao?: string | null
          sono_horas?: number | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "missao_dia_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      perfil_comportamental: {
        Row: {
          apoio_familiar: string | null
          created_at: string | null
          gratidao_hoje: string | null
          id: string
          motivacao_principal: string | null
          motivo_desistencia: string | null
          motivo_desistencia_outro: string | null
          nivel_autocuidado: number | null
          nivel_estresse: number | null
          sentimento_hoje: string | null
          tentativa_emagrecimento: string | null
          tentativa_emagrecimento_outro: string | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          apoio_familiar?: string | null
          created_at?: string | null
          gratidao_hoje?: string | null
          id?: string
          motivacao_principal?: string | null
          motivo_desistencia?: string | null
          motivo_desistencia_outro?: string | null
          nivel_autocuidado?: number | null
          nivel_estresse?: number | null
          sentimento_hoje?: string | null
          tentativa_emagrecimento?: string | null
          tentativa_emagrecimento_outro?: string | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          apoio_familiar?: string | null
          created_at?: string | null
          gratidao_hoje?: string | null
          id?: string
          motivacao_principal?: string | null
          motivo_desistencia?: string | null
          motivo_desistencia_outro?: string | null
          nivel_autocuidado?: number | null
          nivel_estresse?: number | null
          sentimento_hoje?: string | null
          tentativa_emagrecimento?: string | null
          tentativa_emagrecimento_outro?: string | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "perfil_comportamental_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      pesagens: {
        Row: {
          agua_corporal_pct: number | null
          created_at: string | null
          data_medicao: string | null
          gordura_corporal_pct: number | null
          gordura_visceral: number | null
          id: string
          massa_muscular_kg: number | null
          massa_ossea_kg: number | null
          origem_medicao: string | null
          peso_kg: number | null
          taxa_metabolica_basal: number | null
          tipo_corpo: string | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          agua_corporal_pct?: number | null
          created_at?: string | null
          data_medicao?: string | null
          gordura_corporal_pct?: number | null
          gordura_visceral?: number | null
          id?: string
          massa_muscular_kg?: number | null
          massa_ossea_kg?: number | null
          origem_medicao?: string | null
          peso_kg?: number | null
          taxa_metabolica_basal?: number | null
          tipo_corpo?: string | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          agua_corporal_pct?: number | null
          created_at?: string | null
          data_medicao?: string | null
          gordura_corporal_pct?: number | null
          gordura_visceral?: number | null
          id?: string
          massa_muscular_kg?: number | null
          massa_ossea_kg?: number | null
          origem_medicao?: string | null
          peso_kg?: number | null
          taxa_metabolica_basal?: number | null
          tipo_corpo?: string | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "pesagens_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      pontuacao_diaria: {
        Row: {
          categoria_dia: string | null
          created_at: string
          data: string
          id: string
          pontos_agua: number | null
          pontos_atividade_fisica: number | null
          pontos_avaliacao_dia: number | null
          pontos_conexao_interna: number | null
          pontos_energia_acordar: number | null
          pontos_estresse: number | null
          pontos_fome_emocional: number | null
          pontos_gratidao: number | null
          pontos_intencao_amanha: number | null
          pontos_liquido_manha: number | null
          pontos_pequena_vitoria: number | null
          pontos_sono: number | null
          total_pontos_dia: number | null
          updated_at: string
          user_id: string
        }
        Insert: {
          categoria_dia?: string | null
          created_at?: string
          data: string
          id?: string
          pontos_agua?: number | null
          pontos_atividade_fisica?: number | null
          pontos_avaliacao_dia?: number | null
          pontos_conexao_interna?: number | null
          pontos_energia_acordar?: number | null
          pontos_estresse?: number | null
          pontos_fome_emocional?: number | null
          pontos_gratidao?: number | null
          pontos_intencao_amanha?: number | null
          pontos_liquido_manha?: number | null
          pontos_pequena_vitoria?: number | null
          pontos_sono?: number | null
          total_pontos_dia?: number | null
          updated_at?: string
          user_id: string
        }
        Update: {
          categoria_dia?: string | null
          created_at?: string
          data?: string
          id?: string
          pontos_agua?: number | null
          pontos_atividade_fisica?: number | null
          pontos_avaliacao_dia?: number | null
          pontos_conexao_interna?: number | null
          pontos_energia_acordar?: number | null
          pontos_estresse?: number | null
          pontos_fome_emocional?: number | null
          pontos_gratidao?: number | null
          pontos_intencao_amanha?: number | null
          pontos_liquido_manha?: number | null
          pontos_pequena_vitoria?: number | null
          pontos_sono?: number | null
          total_pontos_dia?: number | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          altura_cm: number | null
          celular: string | null
          created_at: string | null
          data_nascimento: string | null
          email: string | null
          full_name: string | null
          id: string
          role: Database["public"]["Enums"]["app_role"] | null
          sexo: Database["public"]["Enums"]["sexo_enum"] | null
          updated_at: string | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          celular?: string | null
          created_at?: string | null
          data_nascimento?: string | null
          email?: string | null
          full_name?: string | null
          id?: string
          role?: Database["public"]["Enums"]["app_role"] | null
          sexo?: Database["public"]["Enums"]["sexo_enum"] | null
          updated_at?: string | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          celular?: string | null
          created_at?: string | null
          data_nascimento?: string | null
          email?: string | null
          full_name?: string | null
          id?: string
          role?: Database["public"]["Enums"]["app_role"] | null
          sexo?: Database["public"]["Enums"]["sexo_enum"] | null
          updated_at?: string | null
          user_id?: string
        }
        Relationships: []
      }
      user_points: {
        Row: {
          best_streak: number | null
          completed_challenges: number | null
          created_at: string | null
          current_streak: number | null
          daily_points: number | null
          id: string
          last_activity_date: string | null
          monthly_points: number | null
          total_points: number | null
          updated_at: string | null
          user_id: string
          weekly_points: number | null
        }
        Insert: {
          best_streak?: number | null
          completed_challenges?: number | null
          created_at?: string | null
          current_streak?: number | null
          daily_points?: number | null
          id?: string
          last_activity_date?: string | null
          monthly_points?: number | null
          total_points?: number | null
          updated_at?: string | null
          user_id: string
          weekly_points?: number | null
        }
        Update: {
          best_streak?: number | null
          completed_challenges?: number | null
          created_at?: string | null
          current_streak?: number | null
          daily_points?: number | null
          id?: string
          last_activity_date?: string | null
          monthly_points?: number | null
          total_points?: number | null
          updated_at?: string | null
          user_id?: string
          weekly_points?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "user_points_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      is_admin: {
        Args: { user_id: string }
        Returns: boolean
      }
    }
    Enums: {
      app_role: "admin" | "client"
      challenge_category: "biologico" | "psicologico"
      challenge_level: "iniciante" | "intermediario" | "avancado"
      sexo_enum: "masculino" | "feminino" | "outro"
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
    Enums: {
      app_role: ["admin", "client"],
      challenge_category: ["biologico", "psicologico"],
      challenge_level: ["iniciante", "intermediario", "avancado"],
      sexo_enum: ["masculino", "feminino", "outro"],
    },
  },
} as const
