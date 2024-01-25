unit frmmain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, System.Actions, Vcl.ActnList;

type
  TCliente = class
  private
    FIDCliente: Integer;
    FNome: string;
    FCPF: string;
    FDataNascimento: TDate;
  public
    property IDCliente: Integer read FIDCliente write FIDCliente;
    property Nome: string read FNome write FNome;
    property CPF: string read FCPF write FCPF;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
  end;

  TCarro = class
  private
    FIDCarro: Integer;
    FModelo: string;
    FDataLancamento: TDate;
  public
    property IDCarro: Integer read FIDCarro write FIDCarro;
    property Modelo: string read FModelo write FModelo;
    property DataLancamento: TDate read FDataLancamento write FDataLancamento;
  end;

  TVenda = class
  private
    FIDVenda: Integer;
    FIDCliente: Integer;
    FIDCarro: Integer;
    FDataVenda: TDate;
    FValorVenda: Double;
  public
    property IDVenda: Integer read FIDVenda write FIDVenda;
    property IDCliente: Integer read FIDCliente write FIDCliente;
    property IDCarro: Integer read FIDCarro write FIDCarro;
    property DataVenda: TDate read FDataVenda write FDataVenda;
    property ValorVenda: Double read FValorVenda write FValorVenda;
  end;

   TFrmPrincipal = class(TForm)
    BtnCadCliente: TButton;
    ActionList1: TActionList;
    ActCadCliente: TAction;
    Button1: TButton;
    ActCadVeiculo: TAction;
    Button2: TButton;
    ActCadVendas: TAction;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    actExcuiVendas: TAction;
    ActQtdMarea: TAction;
    ActQtdUno: TAction;
    ActSemVendas: TAction;
    ActSorteados: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActCadClienteExecute(Sender: TObject);
    procedure ActCadVeiculoExecute(Sender: TObject);
    procedure ActCadVendasExecute(Sender: TObject);
    procedure actExcuiVendasExecute(Sender: TObject);
    procedure ActQtdMareaExecute(Sender: TObject);
    procedure ActQtdUnoExecute(Sender: TObject);
    procedure ActSemVendasExecute(Sender: TObject);
    procedure ActSorteadosExecute(Sender: TObject);
  private
    procedure Inserir(Entidade: TObject);
    procedure InserirDadosBD(SQL: string);
    function ExecutarSql(SQL: string): Variant;
    function getSQLClientesSorteados: String;
  public
    procedure CriarTabelas;
  end;
var
  FrmPrincipal: TFrmPrincipal;

const
    ID_MAREA = 1;
    ID_UNO = 2;
    ArrCLIENTE: array [0..4] of string = ('José', 'Rodrigo', 'Renato', 'Pedro', 'João');
    ArrCPF: array [0..4] of string = ('12345678910', '98765432109', '00100200304', '01002003000', '10020030040');
    ArrCARRO: array [0..4] of string = ('Marea', 'Uno', 'Palio', '500', 'Punto');

implementation

{$R *.dfm}

{TMain}
//---------------------------------------**
procedure TFrmPrincipal.Inserir(Entidade: TObject);
//---------------------------------------**
var
    SQL: string;
begin
    if Entidade is TCliente then
    begin
        SQL := ' INSERT INTO public.cliente( ';
        SQL := SQL + 'nome, cpf, data_nascimento) ';
        SQL := SQL + ' VALUES (';
        SQL := SQL + QuotedStr(TCliente(Entidade).Nome) + ',';
        SQL := SQL + QuotedStr(TCliente(Entidade).Cpf) +  ',';
        SQL := SQL + QuotedStr(DateToStr(TCliente(Entidade).DataNascimento));
        SQL := SQL + ')';
    end
    else if Entidade is TCarro then
    begin
        SQL := ' INSERT INTO public.carro(';
        SQL := SQL + ' modelo, data_lancamento) ';
        SQL := SQL + ' VALUES (';
        SQL := SQL + QuotedStr(TCarro(Entidade).Modelo) + ',';
        SQL := SQL + QuotedStr(DateToStr(TCarro(Entidade).DataLancamento)) + ',';
        SQL := SQL + ')';
    end
    else if Entidade is TVenda then
    begin
        SQL := ' INSERT INTO public.venda(';
        SQL := SQL + ' id_cliente, id_carro, data_venda, valor_venda)';
        SQL := SQL + ' VALUES ( ';
        SQL := SQL + QuotedStr(IntToStr(TVenda(Entidade).IDCliente)) + ',';
        SQL := SQL + QuotedStr(IntToStr(TVenda(Entidade).IDCarro)) + ',';
        SQL := SQL + QuotedStr(DateToStr(TVenda(Entidade).DataVenda)) + ',';
        SQL := SQL + QuotedStr(FloatToStr(TVenda(Entidade).ValorVenda)) + ',';
        SQL := SQL + ')';
    end;

    InserirDadosBD(SQL);
end;
//---------------------------------------------**
function TFrmPrincipal.ExecutarSql(SQL: string): Variant;
//---------------------------------------------**
begin
    Result := 0;
end;
//----------------------------------------**
procedure TFrmPrincipal.FormCreate(Sender: TObject);
//----------------------------------------**
begin
    CriarTabelas;
end;
//--------------------------------------------------**
procedure TFrmPrincipal.ActCadClienteExecute(Sender: TObject);
//--------------------------------------------------**
var
    I: Integer;
    Cliente: TCliente;
begin
    for I := 1 to 5 do
    begin
        Cliente := TCliente.Create;
        Cliente.Nome := ArrCLIENTE[I];
        Cliente.CPF := ArrCPF[I];
        Cliente.DataNascimento := EncodeDate(2000, 1, 1) + I;
        Inserir(Cliente);
        Cliente.Free;
    end;
end;
//--------------------------------------------------**
procedure TFrmPrincipal.ActCadVeiculoExecute(Sender: TObject);
//--------------------------------------------------**
var
    I: Integer;
    Carro: TCarro;
begin
    for I := 1 to 5 do
    begin
        Carro := TCarro.Create;
        Carro.Modelo := ArrCARRO[I];
        Carro.DataLancamento := EncodeDate(2022, I, 1);
        Inserir(Carro);
        Carro.Free;
    end;
end;
//-------------------------------------------------**
procedure TFrmPrincipal.ActCadVendasExecute(Sender: TObject);
//-------------------------------------------------**
var
    I: Integer;
    Venda: TVenda;
begin
    for I := 1 to 5 do
    begin
        Venda := TVenda.Create;
        Venda.IDCliente := I;
        Venda.IDCarro := I;
        Venda.DataVenda := Now;
        Venda.ValorVenda := 30000+I;
        Inserir(Venda);
        Venda.Free;
    end;
end;
//---------------------------------------------------**
procedure TFrmPrincipal.actExcuiVendasExecute(Sender: TObject);
//---------------------------------------------------**
begin
// not Exists
end;
//------------------------------------------------**
procedure TFrmPrincipal.ActQtdMareaExecute(Sender: TObject);
//------------------------------------------------**
var
    SQL: String;
begin
    SQL := 'SELECT COUNT(*) AS quantidade_vendas_marea ';
    SQL := SQL + ' FROM Venda';
    SQL := SQL + ' WHERE id_carro=' + IntToStr(ID_MAREA);

    ShowMessage(ExecutarSQL(SQL));
end;
//----------------------------------------------**
procedure TFrmPrincipal.ActQtdUnoExecute(Sender: TObject);
//----------------------------------------------**
var
    SQL: String;
begin
   SQL := ' SELECT Cliente.nome, COUNT(*) AS quantidade_vendas_uno ';
   SQL := SQL + ' FROM Venda ';
   SQL := SQL + ' JOIN Cliente ON Venda.id_cliente = Cliente.id_cliente';
   SQL := SQL + ' WHERE Venda.id_carro = '+IntToStr(ID_UNO);
   SQL := SQL + ' GROUP BY venda.Id_Cliente, Cliente.nome';

   ShowMessage(ExecutarSQL(SQL));
end;
//-------------------------------------------------**
procedure TFrmPrincipal.ActSemVendasExecute(Sender: TObject);
//-------------------------------------------------**
var
    SQL: String;
begin
    SQL := 'SELECT COUNT(*) AS quantidade_clientes_sem_venda ';
    SQL := SQL + ' FROM Cliente';
    SQL := SQL + ' LEFT JOIN Venda ON Cliente.id_cliente = Venda.id_cliente';
    SQL := SQL + ' WHERE Venda.id_venda IS NULL';

    ShowMessage(ExecutarSQL(SQL));
end;
//-------------------------------------------------**
procedure TFrmPrincipal.ActSorteadosExecute(Sender: TObject);
//-------------------------------------------------**
var
    SQL: String;
begin
    SQL := 'SELECT Cliente.nome';
    SQL := SQL + ' FROM Cliente';
    SQL := SQL + ' JOIN Venda ON Cliente.id_cliente = Venda.id_cliente';
    SQL := SQL + ' JOIN Carro ON Venda.id_carro = Carro.id_carro';
    SQL := SQL + ' WHERE SUBSTRING(Cliente.cpf, 1, 1) = ''0''';
    SQL := SQL + ' AND EXTRACT (YEAR FROM Carro.data_lancamento) = 2021';
    SQL := SQL + ' GROUP BY Cliente.nome';
    SQL := SQL + ' ORDER BY Venda.data_venda';
    SQL := SQL + ' LIMIT 15';

    ShowMessage(ExecutarSQL(SQL));
end;
procedure TFrmPrincipal.Button6Click(Sender: TObject);
begin

end;

//-------------------------**
procedure TFrmPrincipal.CriarTabelas;
//-------------------------**
begin
  ExecutarSql(
    'CREATE TABLE IF NOT EXISTS Cliente (' +
    '  id_cliente SERIAL PRIMARY KEY,' +
    '  nome VARCHAR(100),' +
    '  cpf VARCHAR(11) UNIQUE,' +
    '  data_nascimento DATE' +
    ');'
  );

  ExecutarSql(
    'CREATE TABLE IF NOT EXISTS Carro (' +
    '  id_carro SERIAL PRIMARY KEY,' +
    '  modelo VARCHAR(50),' +
    '  data_lancamento DATE' +
    ');'
  );

  ExecutarSql(
    'CREATE TABLE IF NOT EXISTS Venda (' +
    '  id_venda SERIAL PRIMARY KEY,' +
    '  id_cliente INT,' +
    '  id_carro INT,' +
    '  data_venda DATE,' +
    '  valor_venda NUMERIC(13,2),'+
    '  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),' +
    '  FOREIGN KEY (id_carro) REFERENCES Carro(id_carro)' +
    ');'
  );
end;
//----------------------------------------**
procedure TFrmPrincipal.InserirDadosBD(SQL: string);
//----------------------------------------**
begin
 //
end;

end.
