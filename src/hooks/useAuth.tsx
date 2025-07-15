import React, { createContext, useContext, useEffect, useState } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { User, Session } from '@supabase/supabase-js';

interface AuthContextType {
  user: User | null;
  session: Session | null;
  signIn: (email: string, password: string) => Promise<{ error: any }>;
  signUp: (email: string, password: string, fullName?: string, celular?: string, dataNascimento?: string, sexo?: string, altura?: number) => Promise<{ error: any }>;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [session, setSession] = useState<Session | null>(null);

  useEffect(() => {
    // Set up auth state listener
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        setSession(session);
        setUser(session?.user ?? null);
      }
    );

    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
      setUser(session?.user ?? null);
    });

    return () => subscription.unsubscribe();
  }, []);

  const signIn = async (email: string, password: string) => {
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    return { error };
  };

  const signUp = async (email: string, password: string, fullName?: string, celular?: string, dataNascimento?: string, sexo?: string, altura?: number) => {
    const redirectUrl = `${window.location.origin}/`;
    
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: redirectUrl,
        data: {
          full_name: fullName || '',
          celular: celular || '',
          data_nascimento: dataNascimento || '',
          sexo: sexo || '',
          altura_cm: altura?.toString() || '',
        },
      },
    });
    
    return { error };
  };

  const signOut = async () => {
    try {
      // Limpar todos os dados do localStorage relacionados ao usuário
      if (user) {
        localStorage.removeItem(`physical_data_complete_${user.id}`);
        // Limpar outros dados em cache se necessário
        Object.keys(localStorage).forEach(key => {
          if (key.includes(user.id)) {
            localStorage.removeItem(key);
          }
        });
      }
      
      // Fazer logout no Supabase
      await supabase.auth.signOut();
      
      // Limpar estado local
      setUser(null);
      setSession(null);
      
      // Redirecionar para página inicial (se necessário)
      window.location.href = '/';
      
    } catch (error) {
      console.error('Erro ao fazer logout:', error);
      // Mesmo com erro, limpar estado local
      setUser(null);
      setSession(null);
      window.location.href = '/';
    }
  };

  return (
    <AuthContext.Provider value={{
      user,
      session,
      signIn,
      signUp,
      signOut,
    }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};