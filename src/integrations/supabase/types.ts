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
      comentarios: {
        Row: {
          conteudo: string
          created_at: string
          entrada_diario_id: string | null
          id: string
          tipo: string | null
          updated_at: string
          user_id: string
        }
        Insert: {
          conteudo: string
          created_at?: string
          entrada_diario_id?: string | null
          id?: string
          tipo?: string | null
          updated_at?: string
          user_id: string
        }
        Update: {
          conteudo?: string
          created_at?: string
          entrada_diario_id?: string | null
          id?: string
          tipo?: string | null
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "comentarios_entrada_diario_id_fkey"
            columns: ["entrada_diario_id"]
            isOneToOne: false
            referencedRelation: "entradas_do_diario"
            referencedColumns: ["id"]
          },
        ]
      }
      conquistas: {
        Row: {
          ativa: boolean | null
          created_at: string
          criterio: Json | null
          descricao: string | null
          icone: string | null
          id: string
          nome: string
          pontos_recompensa: number | null
        }
        Insert: {
          ativa?: boolean | null
          created_at?: string
          criterio?: Json | null
          descricao?: string | null
          icone?: string | null
          id?: string
          nome: string
          pontos_recompensa?: number | null
        }
        Update: {
          ativa?: boolean | null
          created_at?: string
          criterio?: Json | null
          descricao?: string | null
          icone?: string | null
          id?: string
          nome?: string
          pontos_recompensa?: number | null
        }
        Relationships: []
      }
      conquistas_do_usuario: {
        Row: {
          conquista_id: string
          created_at: string
          data_conquista: string
          id: string
          user_id: string
        }
        Insert: {
          conquista_id: string
          created_at?: string
          data_conquista?: string
          id?: string
          user_id: string
        }
        Update: {
          conquista_id?: string
          created_at?: string
          data_conquista?: string
          id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "conquistas_do_usuario_conquista_id_fkey"
            columns: ["conquista_id"]
            isOneToOne: false
            referencedRelation: "conquistas"
            referencedColumns: ["id"]
          },
        ]
      }
      dados_fisicos_usuario: {
        Row: {
          agua_corporal_pct: number | null
          altura_cm: number | null
          created_at: string
          gordura_corporal_pct: number | null
          gordura_visceral: number | null
          id: string
          imc: number | null
          massa_muscular_kg: number | null
          peso_kg: number | null
          taxa_metabolica_basal: number | null
          updated_at: string
          user_id: string
        }
        Insert: {
          agua_corporal_pct?: number | null
          altura_cm?: number | null
          created_at?: string
          gordura_corporal_pct?: number | null
          gordura_visceral?: number | null
          id?: string
          imc?: number | null
          massa_muscular_kg?: number | null
          peso_kg?: number | null
          taxa_metabolica_basal?: number | null
          updated_at?: string
          user_id: string
        }
        Update: {
          agua_corporal_pct?: number | null
          altura_cm?: number | null
          created_at?: string
          gordura_corporal_pct?: number | null
          gordura_visceral?: number | null
          id?: string
          imc?: number | null
          massa_muscular_kg?: number | null
          peso_kg?: number | null
          taxa_metabolica_basal?: number | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      dados_saude_usuario: {
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
      desafios: {
        Row: {
          ativo: boolean | null
          created_at: string
          data_fim: string
          data_inicio: string
          descricao: string | null
          id: string
          meta: Json | null
          nome: string
          recompensa: number | null
          tipo: string
        }
        Insert: {
          ativo?: boolean | null
          created_at?: string
          data_fim: string
          data_inicio: string
          descricao?: string | null
          id?: string
          meta?: Json | null
          nome: string
          recompensa?: number | null
          tipo: string
        }
        Update: {
          ativo?: boolean | null
          created_at?: string
          data_fim?: string
          data_inicio?: string
          descricao?: string | null
          id?: string
          meta?: Json | null
          nome?: string
          recompensa?: number | null
          tipo?: string
        }
        Relationships: []
      }
      desafios_do_usuario: {
        Row: {
          concluido: boolean | null
          created_at: string
          data_conclusao: string | null
          data_inicio: string
          desafio_id: string
          id: string
          progresso: number | null
          user_id: string
        }
        Insert: {
          concluido?: boolean | null
          created_at?: string
          data_conclusao?: string | null
          data_inicio?: string
          desafio_id: string
          id?: string
          progresso?: number | null
          user_id: string
        }
        Update: {
          concluido?: boolean | null
          created_at?: string
          data_conclusao?: string | null
          data_inicio?: string
          desafio_id?: string
          id?: string
          progresso?: number | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "desafios_do_usuario_desafio_id_fkey"
            columns: ["desafio_id"]
            isOneToOne: false
            referencedRelation: "desafios"
            referencedColumns: ["id"]
          },
        ]
      }
      entradas_do_diario: {
        Row: {
          conteudo: string
          created_at: string
          data_entrada: string
          energia: number | null
          humor: number | null
          id: string
          stress: number | null
          tags: string[] | null
          updated_at: string
          user_id: string
        }
        Insert: {
          conteudo: string
          created_at?: string
          data_entrada: string
          energia?: number | null
          humor?: number | null
          id?: string
          stress?: number | null
          tags?: string[] | null
          updated_at?: string
          user_id: string
        }
        Update: {
          conteudo?: string
          created_at?: string
          data_entrada?: string
          energia?: number | null
          humor?: number | null
          id?: string
          stress?: number | null
          tags?: string[] | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      favoritos: {
        Row: {
          created_at: string
          id: string
          item_id: string
          item_tipo: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          item_id: string
          item_tipo: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          item_id?: string
          item_tipo?: string
          user_id?: string
        }
        Relationships: []
      }
      historico_medidas: {
        Row: {
          created_at: string
          data_medida: string
          id: string
          observacoes: string | null
          tipo_medida: string
          unidade: string
          user_id: string
          valor: number
        }
        Insert: {
          created_at?: string
          data_medida?: string
          id?: string
          observacoes?: string | null
          tipo_medida: string
          unidade: string
          user_id: string
          valor: number
        }
        Update: {
          created_at?: string
          data_medida?: string
          id?: string
          observacoes?: string | null
          tipo_medida?: string
          unidade?: string
          user_id?: string
          valor?: number
        }
        Relationships: []
      }
      interacoes: {
        Row: {
          created_at: string
          id: string
          item_id: string
          tipo_interacao: string
          user_id: string
          valor: number | null
        }
        Insert: {
          created_at?: string
          id?: string
          item_id: string
          tipo_interacao: string
          user_id: string
          valor?: number | null
        }
        Update: {
          created_at?: string
          id?: string
          item_id?: string
          tipo_interacao?: string
          user_id?: string
          valor?: number | null
        }
        Relationships: []
      }
      metas: {
        Row: {
          created_at: string
          data_fim: string | null
          data_inicio: string
          descricao: string | null
          id: string
          status: string | null
          tipo_meta: string
          unidade: string
          updated_at: string
          user_id: string
          valor_alvo: number
          valor_atual: number | null
        }
        Insert: {
          created_at?: string
          data_fim?: string | null
          data_inicio: string
          descricao?: string | null
          id?: string
          status?: string | null
          tipo_meta: string
          unidade: string
          updated_at?: string
          user_id: string
          valor_alvo: number
          valor_atual?: number | null
        }
        Update: {
          created_at?: string
          data_fim?: string | null
          data_inicio?: string
          descricao?: string | null
          id?: string
          status?: string | null
          tipo_meta?: string
          unidade?: string
          updated_at?: string
          user_id?: string
          valor_alvo?: number
          valor_atual?: number | null
        }
        Relationships: []
      }
      missao_dia: {
        Row: {
          created_at: string
          data: string
          id: string
          missao_1_completa: boolean | null
          missao_2_completa: boolean | null
          missao_3_completa: boolean | null
          missao_4_completa: boolean | null
          missao_5_completa: boolean | null
          pontuacao_total: number | null
          updated_at: string
          user_id: string
        }
        Insert: {
          created_at?: string
          data: string
          id?: string
          missao_1_completa?: boolean | null
          missao_2_completa?: boolean | null
          missao_3_completa?: boolean | null
          missao_4_completa?: boolean | null
          missao_5_completa?: boolean | null
          pontuacao_total?: number | null
          updated_at?: string
          user_id: string
        }
        Update: {
          created_at?: string
          data?: string
          id?: string
          missao_1_completa?: boolean | null
          missao_2_completa?: boolean | null
          missao_3_completa?: boolean | null
          missao_4_completa?: boolean | null
          missao_5_completa?: boolean | null
          pontuacao_total?: number | null
          updated_at?: string
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
      missoes_usuario: {
        Row: {
          completada: boolean | null
          created_at: string
          data_missao: string
          id: string
          missao_id: number
          pontuacao: number | null
          updated_at: string
          user_id: string
        }
        Insert: {
          completada?: boolean | null
          created_at?: string
          data_missao: string
          id?: string
          missao_id: number
          pontuacao?: number | null
          updated_at?: string
          user_id: string
        }
        Update: {
          completada?: boolean | null
          created_at?: string
          data_missao?: string
          id?: string
          missao_id?: number
          pontuacao?: number | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      perfil_comportamental: {
        Row: {
          created_at: string
          id: string
          motivadores: Json | null
          preferencias: Json | null
          sabotadores: Json | null
          tipo_personalidade: string | null
          updated_at: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          motivadores?: Json | null
          preferencias?: Json | null
          sabotadores?: Json | null
          tipo_personalidade?: string | null
          updated_at?: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          motivadores?: Json | null
          preferencias?: Json | null
          sabotadores?: Json | null
          tipo_personalidade?: string | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      perfis: {
        Row: {
          altura_cm: number | null
          atualizado_em: string
          celular: string | null
          criado_em: string
          data_nascimento: string | null
          email: string
          funcao_do_usuario: string | null
          id: string
          nome_completo: string | null
          sexo: string | null
          user_id: string
        }
        Insert: {
          altura_cm?: number | null
          atualizado_em?: string
          celular?: string | null
          criado_em?: string
          data_nascimento?: string | null
          email: string
          funcao_do_usuario?: string | null
          id?: string
          nome_completo?: string | null
          sexo?: string | null
          user_id: string
        }
        Update: {
          altura_cm?: number | null
          atualizado_em?: string
          celular?: string | null
          criado_em?: string
          data_nascimento?: string | null
          email?: string
          funcao_do_usuario?: string | null
          id?: string
          nome_completo?: string | null
          sexo?: string | null
          user_id?: string
        }
        Relationships: []
      }
      pesagens: {
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
      pontos_do_usuario: {
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
      pontuacao_diaria: {
        Row: {
          categoria_dia: string | null
          created_at: string
          data: string
          id: string
          total_pontos_dia: number | null
          user_id: string
        }
        Insert: {
          categoria_dia?: string | null
          created_at?: string
          data: string
          id?: string
          total_pontos_dia?: number | null
          user_id: string
        }
        Update: {
          categoria_dia?: string | null
          created_at?: string
          data?: string
          id?: string
          total_pontos_dia?: number | null
          user_id?: string
        }
        Relationships: []
      }
      respostas_de_teste: {
        Row: {
          created_at: string
          id: string
          respostas: Json
          resultado: Json | null
          teste_id: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          respostas: Json
          resultado?: Json | null
          teste_id: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          respostas?: Json
          resultado?: Json | null
          teste_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "respostas_de_teste_teste_id_fkey"
            columns: ["teste_id"]
            isOneToOne: false
            referencedRelation: "testes"
            referencedColumns: ["id"]
          },
        ]
      }
      sessoes: {
        Row: {
          anotacoes: string | null
          conteudo: Json | null
          created_at: string
          data_sessao: string
          duracao_minutos: number | null
          id: string
          status: string | null
          tipo_sessao: string
          updated_at: string
          user_id: string
        }
        Insert: {
          anotacoes?: string | null
          conteudo?: Json | null
          created_at?: string
          data_sessao: string
          duracao_minutos?: number | null
          id?: string
          status?: string | null
          tipo_sessao: string
          updated_at?: string
          user_id: string
        }
        Update: {
          anotacoes?: string | null
          conteudo?: Json | null
          created_at?: string
          data_sessao?: string
          duracao_minutos?: number | null
          id?: string
          status?: string | null
          tipo_sessao?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      testes: {
        Row: {
          ativo: boolean | null
          created_at: string
          descricao: string | null
          id: string
          nome: string
          perguntas: Json
          tipo: string
        }
        Insert: {
          ativo?: boolean | null
          created_at?: string
          descricao?: string | null
          id?: string
          nome: string
          perguntas: Json
          tipo: string
        }
        Update: {
          ativo?: boolean | null
          created_at?: string
          descricao?: string | null
          id?: string
          nome?: string
          perguntas?: Json
          tipo?: string
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
