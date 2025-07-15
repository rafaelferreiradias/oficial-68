import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';

export interface Course {
  id: string;
  title: string;
  description: string | null;
  thumbnail: string | null;
  category: string | null;
  video_url: string | null;
  duration_minutes: number | null;
  is_premium: boolean | null;
  created_at: string | null;
  updated_at: string | null;
}

export const useCourses = () => {
  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchCourses();
  }, []);

  const fetchCourses = async () => {
    try {
      const { data, error } = await supabase
        .from('courses')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      setCourses(data || []);
    } catch (error) {
      console.error('Erro ao buscar cursos:', error);
    } finally {
      setLoading(false);
    }
  };

  const createCourse = async (courseData: Omit<Course, 'id' | 'created_at' | 'updated_at'>) => {
    try {
      const { data, error } = await supabase
        .from('courses')
        .insert([courseData])
        .select()
        .single();

      if (error) throw error;
      
      setCourses(prev => [data, ...prev]);
      return data;
    } catch (error) {
      console.error('Erro ao criar curso:', error);
      throw error;
    }
  };

  const updateCourse = async (id: string, updates: Partial<Course>) => {
    try {
      const { data, error } = await supabase
        .from('courses')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;

      setCourses(prev => prev.map(course => course.id === id ? data : course));
      return data;
    } catch (error) {
      console.error('Erro ao atualizar curso:', error);
      throw error;
    }
  };

  const deleteCourse = async (id: string) => {
    try {
      const { error } = await supabase
        .from('courses')
        .delete()
        .eq('id', id);

      if (error) throw error;

      setCourses(prev => prev.filter(course => course.id !== id));
    } catch (error) {
      console.error('Erro ao excluir curso:', error);
      throw error;
    }
  };

  // Mock functions for missing functionality
  const fetchCourseModules = async (courseId: string) => {
    // Return empty array since we don't have modules table
    return [];
  };

  const createModule = async (moduleData: any) => {
    // Mock function - would need modules table
    console.log('Creating module:', moduleData);
    return { id: Date.now().toString(), ...moduleData };
  };

  const createLesson = async (lessonData: any) => {
    // Mock function - would need lessons table
    console.log('Creating lesson:', lessonData);
    return { id: Date.now().toString(), ...lessonData };
  };

  return {
    courses,
    loading,
    refetch: fetchCourses,
    createCourse,
    updateCourse,
    deleteCourse,
    fetchCourseModules,
    createModule,
    createLesson
  };
};