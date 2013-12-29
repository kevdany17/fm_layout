# encoding: utf-8
require 'spec_helper'

describe 'DSL para generar el layout de Facturación moderna' do
  context 'factura' do
    context 'llenando todos los campos' do
      let(:hora) {Time.now.strftime("%FT%T")}
      let(:prueba) do
        # DSL
        FmLayout.define_layout do |f|
          f.encabezado do |e|
            e.serie 'A'
            e.folio 10
            e.fecha hora
            e.tipo_de_comprobante 'ingreso'
            e.forma_de_pago 'PAGO EN UNA SOLA EXHIBICIÓN'
            e.metodo_de_pago 'Transferencia Electrónica'
            e.condiciones_de_pago 'Contado'
            e.numero_de_cuenta_de_pago '0098-HSBC'
            e.subtotal 100.00
            e.descuento 0.00
            e.total 116.00
            e.moneda 'MXN'
            e.tipo_de_cambio 1.0
            e.numero_de_certificado '111222111'
            e.lugar_de_expedicion 'Nuevo León, México'
          end
          f.datos_adicionales do |d|
            d.tipo_de_documento 'Factura'
            d.numero_de_pedido '123456'
            d.observaciones 'Efectos Fiscales al Pago'
          end
          f.emisor do |e|
            e.rfc 'TUMG620310R95'
            e.nombre 'FACTURACION MODERNA S.A de C.V.'
            e.regimen_fiscal 'REGIMEN GENERAL DE LEY PERSONAS MORALES'
          end
          f.domicilio_fiscal do |d|
            d.calle 'Calle 1'
            d.numero_exterior 'Número Exterior'
            d.numero_interior 'Número Interior'
            d.colonia 'Colonia'
            d.localidad 'Localidad'
            d.municipio 'Municipio'
            d.estado 'NUEVO LEON'
            d.pais 'México'
            d.codigo_postal '66260'
          end
          f.expedido_en do |d|
            d.calle 'Calle 2'
            d.numero_exterior 'Número Exterior 2'
            d.numero_interior 'Número Interior 2'
            d.colonia 'Colonia 2'
            d.localidad 'Localidad 2'
            d.municipio 'Municipio 2'
            d.estado 'OAXACA'
            d.pais 'México'
            d.codigo_postal '68000'
          end
          f.receptor do |r|
            r.rfc 'XAXX010101000'
            r.nombre 'PUBLICO EN GENERAL'
            r.numero_de_cliente '987654'
            r.email 'soporte@facturacionmoderna.com'
          end
          f.domicilio do |d|
            d.calle 'Calle 3'
            d.numero_exterior 'Número Exterior 3'
            d.numero_interior 'Número Interior 3'
            d.colonia 'Colonia 3'
            d.localidad 'Localidad 3'
            d.municipio 'Municipio 3'
            d.estado 'PUEBLA'
            d.pais 'México'
            d.codigo_postal '72500'
          end

        end
      end

      context 'encabezado' do
        let(:encabezado){ prueba.to_h['Encabezado'] }
        it{ expect(encabezado['serie']).to eq('A') }
        it{ expect(encabezado['folio']).to eq(10) }
        it{ expect(encabezado['fecha']).to eq(hora) }
        it{ expect(encabezado['tipoDeComprobante']).to eq('ingreso') }
        it{ expect(encabezado['formaDePago']).to eq('PAGO EN UNA SOLA EXHIBICIÓN') }
        it{ expect(encabezado['condicionesDePago']).to eq('Contado') }
        it{ expect(encabezado['subTotal']).to eq(100.00) }
        it{ expect(encabezado['descuento']).to eq(0.00) }
        it{ expect(encabezado['total']).to eq(116.00) }
        it{ expect(encabezado['Moneda']).to eq('MXN') }
        it{ expect(encabezado['TipoCambio']).to eq(1.0) }
        it{ expect(encabezado['noCertificado']).to eq('111222111') }
        it{ expect(encabezado['LugarExpedicion']).to eq('Nuevo León, México') }
      end

      context 'datos adicionales' do
        let(:datos_adicionales){ prueba.to_h['Datos Adicionales'] }
        it{ expect(datos_adicionales['tipoDocumento']).to eq('Factura') }
        it{ expect(datos_adicionales['numeropedido']).to eq('123456') }
        it{ expect(datos_adicionales['observaciones']).to eq('Efectos Fiscales al Pago') }
      end

      context 'emisor' do
        let(:emisor){ prueba.to_h['Emisor'] }
        it{ expect(emisor['rfc']).to eq('TUMG620310R95') }
        it{ expect(emisor['nombre']).to eq('FACTURACION MODERNA S.A de C.V.') }
        it{ expect(emisor['RegimenFiscal']).to eq('REGIMEN GENERAL DE LEY PERSONAS MORALES') }
      end

      context 'domicilio fiscal' do
        let(:domicilio_fiscal){ prueba.to_h['DomicilioFiscal'] }
        it{ expect(domicilio_fiscal['calle']).to eq('Calle 1') }
        it{ expect(domicilio_fiscal['noExterior']).to eq('Número Exterior') }
        it{ expect(domicilio_fiscal['noInterior']).to eq('Número Interior') }
        it{ expect(domicilio_fiscal['colonia']).to eq('Colonia') }
        it{ expect(domicilio_fiscal['localidad']).to eq('Localidad') }
        it{ expect(domicilio_fiscal['municipio']).to eq('Municipio') }
        it{ expect(domicilio_fiscal['estado']).to eq('NUEVO LEON') }
        it{ expect(domicilio_fiscal['pais']).to eq('México') }
        it{ expect(domicilio_fiscal['codigoPostal']).to eq('66260') }
      end

      context 'expedido en' do
        let(:expedido_en){ prueba.to_h['ExpedidoEn'] }
        it{ expect(expedido_en['calle']).to eq('Calle 2') }
        it{ expect(expedido_en['noExterior']).to eq('Número Exterior 2') }
        it{ expect(expedido_en['noInterior']).to eq('Número Interior 2') }
        it{ expect(expedido_en['colonia']).to eq('Colonia 2') }
        it{ expect(expedido_en['localidad']).to eq('Localidad 2') }
        it{ expect(expedido_en['municipio']).to eq('Municipio 2') }
        it{ expect(expedido_en['estado']).to eq('OAXACA') }
        it{ expect(expedido_en['pais']).to eq('México') }
        it{ expect(expedido_en['codigoPostal']).to eq('68000') }
      end

      context 'receptor' do
        let(:receptor){ prueba.to_h['Receptor'] }
        it{ expect(receptor['rfc']).to eq('XAXX010101000') }
        it{ expect(receptor['nombre']).to eq('PUBLICO EN GENERAL') }
        it{ expect(receptor['NumCliente']).to eq('987654') }
        it{ expect(receptor['emailCliente']).to eq('soporte@facturacionmoderna.com') }
      end

      context 'domilicio' do
        let(:domicilio){ prueba.to_h['Domicilio'] }
        it{ expect(domicilio['calle']).to eq('Calle 3') }
        it{ expect(domicilio['noExterior']).to eq('Número Exterior 3') }
        it{ expect(domicilio['noInterior']).to eq('Número Interior 3') }
        it{ expect(domicilio['colonia']).to eq('Colonia 3') }
        it{ expect(domicilio['localidad']).to eq('Localidad 3') }
        it{ expect(domicilio['municipio']).to eq('Municipio 3') }
        it{ expect(domicilio['estado']).to eq('PUEBLA') }
        it{ expect(domicilio['pais']).to eq('México') }
        it{ expect(domicilio['codigoPostal']).to eq('72500') }
      end


    end
  end
end
