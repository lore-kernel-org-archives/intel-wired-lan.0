From: Gavin Lambert <intel@mirality.co.nz>
Date: Fri, 19 Jul 2019 13:02:08 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
 <000661bda5687541e895a949c76712fb@mirality.co.nz>
 <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
 <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
Message-ID: <f4a18bf808e6f30e9691e127722f851b@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-19 12:40, I wrote:
> FWIW, I added some extra logging around the new code.  I can confirm
> that it does execute on link regain but doesn't actually enter the
> loop in my problem case.  The pcim_state is 0x00080083 at the time.
> So the e1000_phy_hw_reset is never actually called.  If I try changing
> it to call that unconditionally, then it can't successfully establish
> a link in the first place.

I added a call to e1000e_dump at the point of link regain, in hopes that 
it might shed more light.

On startup, when it does successfully link and send/receive packets:

     0000:00:1f.6: Register Dump
       Register Name   Value
      CTRL            58180240
      STATUS          00080083
      CTRL_EXT        995a1027
      ICR             00000000
      RCTL            04008002
      RDLEN           00001000
      RDH             00000000
      RDT             000000f0
      RDTR            00000000
      RXDCTL[0-1]     00010000 00010000
      ERT             00000000
      RDBAL           6061c000
      RDBAH           00000002
      RDFH            00000000
      RDFT            00000000
      RDFHS           00000000
      RDFTS           00000000
      RDFPC           00000000
      TCTL            3103f0f8
      TDBAL           5e8a0000
      TDBAH           00000002
      TDLEN           00001000
      TDH             00000000
      TDT             00000000
      TIDV            00000008
      TXDCTL[0-1]     0141001f 0141001f
      TADV            00000020
      TARC[0-1]       3d800403 45000403
      TDFH            00000d00
      TDFT            00000d00
      TDFHS           00000d00
      TDFTS           00000d00
      TDFPC           00000000
      ecm0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

On disconnecting and reconnecting the cable, when it does get link but 
then can't actually send any packets:

     0000:00:1f.6: Register Dump
       Register Name   Value
      CTRL            58180240
      STATUS          00080083
      CTRL_EXT        995a1027
      ICR             00000000
      RCTL            04008002
      RDLEN           00001000
      RDH             000000d1
      RDT             000000c0
      RDTR            00000000
      RXDCTL[0-1]     00010000 00010000
      ERT             00000000
      RDBAL           6061c000
      RDBAH           00000002
      RDFH            00000582
      RDFT            00000582
      RDFHS           00000582
      RDFTS           00000582
      RDFPC           00000000
      TCTL            3103f0fa
      TDBAL           5e8a0000
      TDBAH           00000002
      TDLEN           00001000
      TDH             00000050
      TDT             0000003d
      TIDV            00000008
      TXDCTL[0-1]     0141001f 0141001f
      TADV            00000020
      TARC[0-1]       3d800403 45000403
      TDFH            00000f0a
      TDFT            00000f1c
      TDFHS           00000f0a
      TDFTS           00000f0a
      TDFPC           00000000
      ecm0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
