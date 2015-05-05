use strict;
use warnings;
use 5.010;
use File::Basename;
use Cwd;
use Switch;
$| = 1;

my $arquivoDB;
my $arquivoPass;
my $arquivoOUT;
my $lstDB;
my $lstFinal;
my $lstPass;
my $Rating;
while(1){
	
	print "---------Script de automatizacao Fortigate ------------\n";
	print "1 - Gerar SCRIPT CLI para URL`s RATING CUSTOM\n";
	print "2 - Gerar SCRIPT CLI para criar Usuarios \n";
	
	my  $leia = <STDIN>;
	chomp $leia;
	
	
	switch ($leia) {
		case 1          { &URL; }
		case 2 			{&Users;}
		else            { last; }
	}
	
}

sub Corpo{
	use Path::Class qw(file);
	
	say "Aquivo database com as URL :";
	say "Padrao: DB.txt :";
	
	my $leia=<STDIN>;
	chomp $leia;
	$arquivoDB= $leia;
	if($leia eq ''){
		$arquivoDB = "DB.txt";
		
	}
	
	
	say "Arquivo de Saida :";
	say "Padrao: final.txt :";
	
	$leia=<STDIN>;
	chomp $leia;
	$arquivoOUT = $leia;
	if($leia eq ''){
		$arquivoOUT = "final.txt";
		
	}
	
	
	$lstDB = file($0)->absolute->dir.'/Dados/'.$arquivoDB;
	$lstFinal = file($0)->absolute->dir.'/'.$arquivoOUT;
	
}

sub Corpo2{
	use Path::Class qw(file);
	
	say "Aquivo database com os Usuarios :";
	say "Padrao: DB.txt :";
	$arquivoDB = "DB.txt";
	
	my $leia=<STDIN>;
	chomp $leia;
	$arquivoDB= $leia;
	if($leia eq ''){
		$arquivoDB = "DB.txt";
		
	}
	
	
	say "Arquivo de passwords :";
	say "Padrao: pass.txt :";
	$leia=<STDIN>;
	chomp $leia;
	if($leia eq ''){
		$arquivoPass= "pass.txt";
		
	}
	$arquivoPass = $leia;
	
	say "Arquivo de Saida :";
	say "Exemplo: final.txt :";
	
	
	$leia=<STDIN>;
	chomp $leia;
	$arquivoOUT = $leia;
	if($leia eq ''){
		$arquivoOUT = "final.txt";
		
	}
	
	
	$lstDB = file($0)->absolute->dir.'/Dados/'.$arquivoDB;
	$lstPass = file($0)->absolute->dir.'/Dados/'.$arquivoPass;
	$lstFinal = file($0)->absolute->dir.'/'.$arquivoOUT;
	
}

sub Users{
	
	&Corpo2;
	
	my $aux =1;
	open(my $fh1,'<', $lstDB) or die "Não foi possível abrir o arquivo '$lstDB' $!";
	open(my $fh2,'<', $lstPass)or die "Não foi possível abrir o arquivo '$lstPass' $!";
	open(my $fh3,'>', $lstFinal) or die "Não foi possível abrir o arquivo '$lstFinal' $!";
	
	while (my $readDB = <$fh1>) {
		my $readPass = <$fh2>;
		if($aux ==1){
			$aux =2;
			print $fh3 "config user local \n"
			
		}
		
		print $fh3 "edit ";
		print $fh3 $readDB;
		print $fh3 "set type password \n";
		print $fh3 "set passwd ";
		print $fh3 $readPass;
		print $fh3 "next \n";
		
	}
	close $fh1;
	close $fh2;
	close $fh3;
	print "Executado com sucesso!!!\n\n\n\n";
}





sub URL{
	
	&Corpo;
	
	my $aux =1;
	open(my $fh1,'<', $lstDB) or die "Não foi possível abrir o arquivo '$lstDB' $!";
	open(my $fh2,'>', $lstFinal)or die "Não foi possível abrir o arquivo '$lstFinal' $!";
	print "- INFORME O RATING CUSTOM -";
	$Rating = <STDIN>;
	chomp $Rating;
	
	while(my $readDB = <$fh1>){
		
		if($aux ==1){
			$aux =2;
			print $fh2 "config webfilter ftgd-local-rating \n"
			
		}
		
		print $fh2 "edit ";
		print $fh2 $readDB;
		print $fh2 "set rating ".$Rating."\n";
		
		print $fh2 "next \n";
		
	}
	close $fh1;
	print "Executado com sucesso!!!\n\n\n\n";
}