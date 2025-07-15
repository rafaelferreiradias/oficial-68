import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertCircle } from 'lucide-react';

interface DisabledAdminFeatureProps {
  title: string;
  description: string;
}

export const DisabledAdminFeature: React.FC<DisabledAdminFeatureProps> = ({ 
  title, 
  description 
}) => {
  return (
    <Card className="opacity-60">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <AlertCircle className="w-5 h-5 text-yellow-500" />
          {title}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="text-center py-8">
          <AlertCircle className="w-12 h-12 mx-auto mb-4 text-yellow-500" />
          <h3 className="font-medium text-gray-900 mb-2">Funcionalidade em Desenvolvimento</h3>
          <p className="text-gray-600 text-sm">
            {description}
          </p>
          <p className="text-gray-500 text-xs mt-2">
            Esta funcionalidade será implementada em breve após a criação das tabelas necessárias.
          </p>
        </div>
      </CardContent>
    </Card>
  );
};

export default DisabledAdminFeature;