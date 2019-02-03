%clc;
% clear all;

lenabmp=imread('C:\Users\muamm\Desktop\Dersler\Say�sal G�r�nt� ��leme\fotolar\lenabmp.bmp');
lenaorj=lenabmp;      %yedek imge
boyutlena=size(lenabmp);

text='One of the earliest machines designed to assist people in calculations was the abacus which is still being used some 5000 years after its invention'; 
text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);    %text

figure,imshow(lenabmp),title('Orjinal');
binarytext = dec2bin(text,8); % texti binary diziler olarak binarytexte kaydeder.
boyuttext=size(binarytext);  %   18816,8
texti=1;textj=1;    % text �zerinde kullan�lacak indexler(binaryde)
sayacc=0;


 %%%%%%%%%%%%%%%%% 2 Bitlik de�i�im %%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:boyutlena(1)  %imgenin her 
  for j=1:1:boyutlena(2)   %katman�na
    for k=1:1:boyutlena(3)    %eri�iliyor
        if(textj>8)      %bir harfin 8 biti de okunduysa bit indexi 1 yap�l�p harf indexi bir artt�r�l�yor
            textj=1; 
            texti=texti+1;
        end     
        binlenapix=dec2bin(lenabmp(i,j,k),8);   % g�rsel, 8 bitlik binary say�larla ifade ediliyor
        
        birtextbinary=binarytext(texti,textj);  % textteki her harfin her bitine tek tek eri�iliyor
        binlenapix(1,7)=birtextbinary;          % g�rseldeli her say�n�n son bitine bir bit yaz�l�yor
        
        birtextbinary=binarytext(texti,textj+1);  
        binlenapix(1,8)=birtextbinary;
        
        declenapix=bin2dec(binlenapix);         % son biti de�i�tirilen say� decimal yap�l�yor
        lenabmp(i,j,k)=declenapix;              % yeni say� g�rselde uygulan�yor
         textj=textj+2;                         % textin okunmu� harfinin di�er bitine ge�iliyor     
         
         sayacc=sayacc+2;
    end
  end  
        if(texti>=boyuttext(1))     %t�m harfler okunmu� ise break
           break;
        end
end

figure,imshow(lenabmp),title('De�i�en');









%%%%%%%%%%%%%%%%%% 1 Bitlik de�i�im %%%%%%%%%%%%%%%%%%%%%%%

 
% for i=1:1:boyutlena(1)  %imgenin her 
%   for j=1:1:boyutlena(2)   %katman�na
%     for k=1:1:boyutlena(3)    %eri�iliyor
%         if(textj>8)      %bir harfin 8 biti de okunduysa bit indexi 1 yap�l�p harf indexi bir artt�r�l�yor
%             textj=1; 
%             texti=texti+1;
%         end     
%         binlenapix=dec2bin(lenabmp(i,j,k),8);   % g�rsel, 8 bitlik binary say�larla ifade ediliyor
%         birtextbinary=binarytext(texti,textj);  % textteki her harfin her bitine tek tek eri�iliyor
%         binlenapix(1,8)=birtextbinary;          % g�rseldeli her say�n�n son bitine bir bit yaz�l�yor
%         declenapix=bin2dec(binlenapix);         % son biti de�i�tirilen say� decimal yap�l�yor
%         lenabmp(i,j,k)=declenapix;              % yeni say� g�rselde uygulan�yor
%          textj=textj+1;                         % textin okunan harfinin di�er bitine ge�iliyor
%         sayacc=sayacc+1;
% 
%     end
% 
%   end  
%         if(texti>=boyuttext(1))     %t�m harfler okunmu� ise break
%            break;
%         end
% end
% 
% figure,imshow(lenabmp),title('De�i�en');
% 








%%%%%%%%%%%%%%%%%  Aradaki fark�n g�rsel hali ;%%%%%%%%%%%%%%%%%%

%       1       0
fark1=lenabmp-lenaorj;     % 	0 -> 1 durumlar�

for i=1:1:boyutlena(1)  %imgenin her 
  for j=1:1:boyutlena(2)   %katman�na
    for k=1:1:boyutlena(3)    %eri�iliyor
        
        if(fark1(i,j,k)>0)
            fark1(i,j,k)=255;
        end
    end
  end
end

%figure,imshow(fark);


%       1       0
fark2=lenaorj-lenabmp;     %  1 -> 0 durumlar�

for i=1:1:boyutlena(1)  %imgenin her 
  for j=1:1:boyutlena(2)   %katman�na
    for k=1:1:boyutlena(3)    %eri�iliyor
        
        if(fark2(i,j,k)>0)
            fark2(i,j,k)=255;
        end
    end
  end
end
%figure,imshow(fark2);
 toplamfark = fark1+fark2;
%  figure,imshow(toplamfark(:,:,1));  % R katman� fark�
%  figure,imshow(toplamfark(:,:,2));  % G katman� fark�
%  figure,imshow(toplamfark(:,:,3));  % B katman� fark�
 figure,imshow(toplamfark);         % Toplam fark


 
 
 %%%%%%%%%%% Histogramlar %%%%%%%%%%%%
 
 
 % De�i�en g�rsel
 lenabmp = double(lenabmp);
 figure,hist(reshape(lenabmp,[],3),1:max(lenabmp(:))),title('De�i�en'); 
    colormap([1 0 0; 0 1 0; 0 0 1]);
 
 % Orjinal g�rsel
 lenaorj = double(lenaorj);
 figure,hist(reshape(lenaorj,[],3),1:max(lenaorj(:))),title('Orjinal'); 
    colormap([1 0 0; 0 1 0; 0 0 1]);
 
 
 %%%%%%%%%%%% MSE ve PSNR %%%%%%%%%%%%%

MSE=immse(lenaorj,lenabmp);             %MSE : Hatalar�n karelerinin ortalamas�
fprintf('\n MSE: %f ', MSE);
% % 
% % MSE2 = sum(sum((lenaorj-lenabmp).^2))/(size(lenaorj,1)*(size(lenaorj,2)));
% % fprintf('\nMSE: %7.2f ', MSE2);
% 
[PSNR,SNR]=psnr(lenaorj,lenabmp,255);             %PSNR :orijinal piksel de�erinin en b�y���n�n, hatan�n b�y�kl���ne oran�
fprintf('\n PSNR: %f dB', PSNR);
fprintf('\n SNR: %f dB', SNR);

%  MSE = sum(sum((lenaorj-lenabmp).^2))/(size(lenaorj,1)*(size(lenaorj,2)));
%   PSNR2 = 10*log10(255*255/MSE);
%   fprintf('\nMSE: %7.2f ', MSE);
%   fprintf('\nPSNR: %9.7f dB', PSNR2);



%%%%%%%%%%%%%%%  Correlation Coefficients  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

CC=corrcoef(lenaorj,lenabmp);
fprintf('\n CC: %f', CC);





