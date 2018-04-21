clear ;

load data_hw_bayes;

K=2; % Ŭ������ ��


% Ŭ������ ǥ�� ��� ���
M=[mean(X1);mean(X2)];
S(:,:,1)=cov(X1);
S(:,:,2)=cov(X2);


% Ŭ������ ǥ�� ���л��� ���
smean=(cov(X1)+cov(X2))/2;


% �н� ������ ���� : 200~
trainData=[X1;X2];


% Ŭ���� �������� ��
N = size(X1,1);



for k=1:K                                 % Ŭ�������� �з� ����
    X=trainData((k-1)*100+1:k*100,:);         % ù��° �ι��� �ݺ��ϱ� ����
    
    for i=1:N                          % �� �����Ϳ� ���� �з� ���� �̰������� 100��
        
        for j=1:K                         % �Ǻ��Լ��� �� ���
            
            % �Ϲ����� ���л������ ������ ����� �Ǻ� �Լ�
            %leftVal = (X(arrayIndex,:)-M(kCount,:));
            %rightVal= inv(reshape(S(:,:,kCount),2,2)) * (X(arrayIndex,:)-M(kCount,:))';
            %d1(kCount,1) = leftVal * rightVal;
            d1(j,i) = (X(i,:)-M(j,:)) * inv(reshape( S(:,:,j),2,2)) * (X(i,:)-M(j,:))';
            
        end
        
        % �Ǻ� �Լ� ���� ���� �з�
        %min�� �ּڰ� v�� �ε��� v�� �˷��ݴϴ�
        [min1v, min1i] = min(d1);
    end
end

for k=1:K                                 % Ŭ�������� �з� ����
    X=trainData((k-1)*100+1:k*100,:);         % ù��° �ι��� �ݺ��ϱ� ����
    
    for i=1:N                          % �� �����Ϳ� ���� �з� ���� �̰������� 100��
        
        for j=1:K                         % �Ǻ��Լ��� �� ���
            
            % �Ϲ����� ���л������ ������ ����� �Ǻ� �Լ�
            %leftVal = (X(arrayIndex,:)-M(kCount,:));
            %rightVal= inv(reshape(S(:,:,kCount),2,2)) * (X(arrayIndex,:)-M(kCount,:))';
            %d1(kCount,1) = leftVal * rightVal;
            d1(j,i) = (X(i,:)-M(j,:)) * inv(reshape( S(:,:,j),2,2)) * (X(i,:)-M(j,:))';
            
        end
        
        % �Ǻ� �Լ� ���� ���� �з�
        %min�� �ּڰ� v�� �ε��� v�� �˷��ݴϴ�
        [min1v, min1i] = min(d1);
    end
end

% x= [1,1] ����
T = [1 1];
for j=1:K
    d2(j,1) = (T(1,:)-M(j,:)) * inv(reshape( S(:,:,j),2,2)) * (T(1,:)-M(j,:))';
end

[min2v, min2i] = min(d2);

classify_res = min2i









