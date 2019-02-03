%clc;
% clear all;

lenabmp=imread('C:\Users\muamm\Desktop\Dersler\Sayýsal Görüntü Ýþleme\fotolar\lenabmp.bmp');
lenaorj=lenabmp;      %yedek imge
boyutlena=size(lenabmp);

text='One of the earliest machines designed to assist people in calculations was the abacus which is still being used some 5000 years after its invention'; 
text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);text=strcat(text,text);    %text

figure,imshow(lenabmp),title('Orjinal');
binarytext = dec2bin(text,8); % texti binary diziler olarak binarytexte kaydeder.
boyuttext=size(binarytext);  %   18816,8
texti=1;textj=1;    % text üzerinde kullanýlacak indexler(binaryde)
sayacc=0;


 %%%%%%%%%%%%%%%%% 2 Bitlik deðiþim %%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:boyutlena(1)  %imgenin her 
  for j=1:1:boyutlena(2)   %katmanýna
    for k=1:1:boyutlena(3)    %eriþiliyor
        if(textj>8)      %bir harfin 8 biti de okunduysa bit indexi 1 yapýlýp harf indexi bir arttýrýlýyor
            textj=1; 
            texti=texti+1;
        end     
        binlenapix=dec2bin(lenabmp(i,j,k),8);   % görsel, 8 bitlik binary sayýlarla ifade ediliyor
        
        birtextbinary=binarytext(texti,textj);  % textteki her harfin her bitine tek tek eriþiliyor
        binlenapix(1,7)=birtextbinary;          % görseldeli her sayýnýn son bitine bir bit yazýlýyor
        
        birtextbinary=binarytext(texti,textj+1);  
        binlenapix(1,8)=birtextbinary;
        
        declenapix=bin2dec(binlenapix);         % son biti deðiþtirilen sayý decimal yapýlýyor
        lenabmp(i,j,k)=declenapix;              % yeni sayý görselde uygulanýyor
         textj=textj+2;                         % textin okunmuþ harfinin diðer bitine geçiliyor     
         
         sayacc=sayacc+2;
    end
  end  
        if(texti>=boyuttext(1))     %tüm harfler okunmuþ ise break
           break;
        end
end

figure,imshow(lenabmp),title('Deðiþen');









%%%%%%%%%%%%%%%%%% 1 Bitlik deðiþim %%%%%%%%%%%%%%%%%%%%%%%

 
% for i=1:1:boyutlena(1)  %imgenin her 
%   for j=1:1:boyutlena(2)   %katmanýna
%     for k=1:1:boyutlena(3)    %eriþiliyor
%         if(textj>8)      %bir harfin 8 biti de okunduysa bit indexi 1 yapýlýp harf indexi bir arttýrýlýyor
%             textj=1; 
%             texti=texti+1;
%         end     
%         binlenapix=dec2bin(lenabmp(i,j,k),8);   % görsel, 8 bitlik binary sayýlarla ifade ediliyor
%         birtextbinary=binarytext(texti,textj);  % textteki her harfin her bitine tek tek eriþiliyor
%         binlenapix(1,8)=birtextbinary;          % görseldeli her sayýnýn son bitine bir bit yazýlýyor
%         declenapix=bin2dec(binlenapix);         % son biti deðiþtirilen sayý decimal yapýlýyor
%         lenabmp(i,j,k)=declenapix;              % yeni sayý görselde uygulanýyor
%          textj=textj+1;                         % textin okunan harfinin diðer bitine geçiliyor
%         sayacc=sayacc+1;
% 
%     end
% 
%   end  
%         if(texti>=boyuttext(1))     %tüm harfler okunmuþ ise break
%            break;
%         end
% end
% 
% figure,imshow(lenabmp),title('Deðiþen');
% 








%%%%%%%%%%%%%%%%%  Aradaki farkýn görsel hali ;%%%%%%%%%%%%%%%%%%

%       1       0
fark1=lenabmp-lenaorj;     % 	0 -> 1 durumlarý

for i=1:1:boyutlena(1)  %imgenin her 
  for j=1:1:boyutlena(2)   %katmanýna
    for k=1:1:boyutlena(3)    %eriþiliyor
        
        if(fark1(i,j,k)>0)
            fark1(i,j,k)=255;
        end
    end
  end
end

%figure,imshow(fark);


%       1       0
fark2=lenaorj-lenabmp;     %  1 -> 0 durumlarý

for i=1:1:boyutlena(1)  %imgenin her 
  for j=1:1:boyutlena(2)   %katmanýna
    for k=1:1:boyutlena(3)    %eriþiliyor
        
        if(fark2(i,j,k)>0)
            fark2(i,j,k)=255;
        end
    end
  end
end
%figure,imshow(fark2);
 toplamfark = fark1+fark2;
%  figure,imshow(toplamfark(:,:,1));  % R katmaný farký
%  figure,imshow(toplamfark(:,:,2));  % G katmaný farký
%  figure,imshow(toplamfark(:,:,3));  % B katmaný farký
 figure,imshow(toplamfark);         % Toplam fark


 
 
 %%%%%%%%%%% Histogramlar %%%%%%%%%%%%
 
 
 % Deðiþen görsel
 lenabmp = double(lenabmp);
 figure,hist(reshape(lenabmp,[],3),1:max(lenabmp(:))),title('Deðiþen'); 
    colormap([1 0 0; 0 1 0; 0 0 1]);
 
 % Orjinal görsel
 lenaorj = double(lenaorj);
 figure,hist(reshape(lenaorj,[],3),1:max(lenaorj(:))),title('Orjinal'); 
    colormap([1 0 0; 0 1 0; 0 0 1]);
 
 
 %%%%%%%%%%%% MSE ve PSNR %%%%%%%%%%%%%

MSE=immse(lenaorj,lenabmp);             %MSE : Hatalarýn karelerinin ortalamasý
fprintf('\n MSE: %f ', MSE);
% % 
% % MSE2 = sum(sum((lenaorj-lenabmp).^2))/(size(lenaorj,1)*(size(lenaorj,2)));
% % fprintf('\nMSE: %7.2f ', MSE2);
% 
[PSNR,SNR]=psnr(lenaorj,lenabmp,255);             %PSNR :orijinal piksel deðerinin en büyüðünün, hatanýn büyüklüðüne oraný
fprintf('\n PSNR: %f dB', PSNR);
fprintf('\n SNR: %f dB', SNR);

%  MSE = sum(sum((lenaorj-lenabmp).^2))/(size(lenaorj,1)*(size(lenaorj,2)));
%   PSNR2 = 10*log10(255*255/MSE);
%   fprintf('\nMSE: %7.2f ', MSE);
%   fprintf('\nPSNR: %9.7f dB', PSNR2);



%%%%%%%%%%%%%%%  Correlation Coefficients  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

CC=corrcoef(lenaorj,lenabmp);
fprintf('\n CC: %f', CC);





