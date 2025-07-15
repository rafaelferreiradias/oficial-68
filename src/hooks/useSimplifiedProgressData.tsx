import { useState, useEffect } from 'react';

export const useProgressData = () => {
  const [progressData, setProgressData] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    setProgressData([]);
  }, []);

  return {
    progressData,
    loading,
    refetch: () => setProgressData([])
  };
};