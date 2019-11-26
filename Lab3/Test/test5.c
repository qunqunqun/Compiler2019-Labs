int main(){
	int x, temp;
	int i =0, y[27];
	int j=0;
	x= read();
	temp = x;
	while(x>0){
		y[i]=x-10*(x/10);
		x= x/10;
		i= i+1;
	}
	while(y[j]==y[i-1-j]&& j<= i/2-1){
		j=j+1;
	}
	if(j==i/2)
		write(1);
	else
		write(0);
	return 0;
}
