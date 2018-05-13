
clear;
load ORL_person_trim.mat
load feature_person

Ntrn=size(train_trim,1);    % �н��������� ��
Ntst=size(test_trim,1);     % �׽�Ʈ �������� ��
lsize=size(train_trim,2);   % �Էº����� ���� ��
Mcls=50;                    % Ŭ������ ��


%=====================================
% Classification Using PCA Feature and LDA Features

% ������ ��� Ư¡ ������ ���Ͽ� �ݺ� ����
for dim=1: Mcls-1
    Wo=orth(W(:,1:dim));       % ���� ������ŭ �� ���к��� ��� ����ȭ
    Y=(Wo'*(train_trim)')';            % PCA Ư¡ ����(�н�)
    Yt=(Wo'*(test_trim)')';   % PCA Ư¡ ����(�׽�Ʈ ������)
    for i=1:Ntst              % �� �׽�Ʈ �����Ϳ� ���� �з� ����
        yt=Yt(i,:);           % �׽�Ʈ �����Ϳ� ���� PCA Ư¡
        zt=Zt(i,1:dim);       % �׽�Ʈ �����Ϳ� ���� LDA Ư¡
        for j=1:Ntrn                    % �н� �����͵���� �Ÿ� ���
            dy(j)=norm(yt-Y(j,1:dim));
            dz(j)=norm(zt-Z(j,1:dim));
        end
        [minvy, miniy]=min(dy); % �ֱ����̿� ã�� (PCA Ư¡)
        [minvz, miniz]=min(dz); % �ֱ����̿� ã�� (LDA Ư¡)
        min_labely(i)=train_label(miniy);   % �ֱ����̿��� Ŭ������ �Ҵ�(PCA)
        min_labelz(i)=train_label(miniz);   % �ֱ����̿��� Ŭ������ �Ҵ�(LDA)
    end
    % �з��� ���(PCA)
    error_labely=find(min_labely-test_label);
    correcty=Ntst-size(error_labely,2);
    classification_ratey(dim)=correcty/Ntst;
    
    % �з��� ��� (LDA)
    error_labelz=find(min_labelz-test_label);
    correctz=Ntst-size(error_labelz,2);
    classification_ratez(dim)=correctz/Ntst;
    [classification_ratey(dim), classification_ratez(dim)];
end

% Ư¡ ���� ���� �з��� ��ȭ �׷��� �׸���
figure(1);
plot([1:49], classification_ratey, 'b-');
hold on
plot([1:49], classification_ratez, 'r-');


