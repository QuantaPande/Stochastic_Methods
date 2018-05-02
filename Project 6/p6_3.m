num=100000;
s=zeros(1,num);
j=5;
tic
sd=ones(1,num);
for k=1:j
    x=rand(1,num);
    sd=sd.*x;
    
end
sum=-log(sd);
toc
histogram(sum)
