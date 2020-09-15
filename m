From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 15 Sep 2020 09:22:08 -0400
Subject: [Intel-wired-lan] i4oe/XXV710 suspect tx_dropped stats
Message-ID: <81307012-3c76-51a9-95cb-2b14a7118467@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ethtool reporting zero. ip -s reporting non-zero.
Which is right? See attached for more details.

cheers,
jamal
-------------- next part --------------

some bus info

b3:00.0 Ethernet controller: Intel Corporation Ethernet Controller XXV710 for 25GbE SFP28 (rev 02)
	Subsystem: Super Micro Computer Inc Ethernet Controller XXV710 for 25GbE SFP28
	Flags: bus master, fast devsel, latency 0, IRQ 270, NUMA node 0
	Memory at 38c000000000 (64-bit, prefetchable) [size=16M]
	Memory at 38c002800000 (64-bit, prefetchable) [size=32K]
	Expansion ROM at fbe80000 [disabled] [size=512K]
	Capabilities: <access denied>
	Kernel driver in use: i40e
	Kernel modules: i40e

jhs at SUT:~/new-proto$ ethtool enp179s0f0 
Settings for enp179s0f0:
	Supported ports: [ FIBRE ]
	Supported link modes:   25000baseCR/Full 
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: None BaseR RS
	Advertised link modes:  25000baseCR/Full 
	Advertised pause frame use: No
	Advertised auto-negotiation: Yes
	Advertised FEC modes: None BaseR RS
	Speed: 25000Mb/s
	Duplex: Full
	Port: Direct Attach Copper
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: on
Cannot get wake-on-lan settings: Operation not permitted
	Current message level: 0x00000007 (7)
			       drv probe link
	Link detected: yes

jhs at SUT:~/new-proto$ ethtool -k enp179s0f0 
Features for enp179s0f0:
rx-checksumming: on
tx-checksumming: on
	tx-checksum-ipv4: on
	tx-checksum-ip-generic: off [fixed]
	tx-checksum-ipv6: on
	tx-checksum-fcoe-crc: off [fixed]
	tx-checksum-sctp: on
scatter-gather: on
	tx-scatter-gather: on
	tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
	tx-tcp-segmentation: on
	tx-tcp-ecn-segmentation: on
	tx-tcp-mangleid-segmentation: off
	tx-tcp6-segmentation: on
udp-fragmentation-offload: off
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed]
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: on
receive-hashing: on
highdma: on
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: on
tx-gre-csum-segmentation: on
tx-ipxip4-segmentation: on
tx-ipxip6-segmentation: on
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on
tx-gso-partial: on
tx-tunnel-remcsum-segmentation: off [fixed]
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
tx-udp-segmentation: on
tx-gso-list: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off
hw-tc-offload: on
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: on
tls-hw-tx-offload: off [fixed]
tls-hw-rx-offload: off [fixed]
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
rx-gro-list: off
macsec-hw-offload: off [fixed]
jhs at SUT:~/new-proto$ 

jhs at SUT:~/new-proto$ ethtool -i enp179s0f0 
driver: i40e
version: 5.9.0-rc1-nfoff+
firmware-version: 6.02 0x800036e3 1.1861.0
expansion-rom-version: 
bus-info: 0000:b3:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
jhs at SUT:~/new-proto$ 

And now notice the tx dropped being reported as zero in the ethtool
output


jhs at SUT:~/new-proto$ ip -s -s l ls enp179s0f0 && ethtool -S enp179s0f0 
4: enp179s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ac:1f:6b:e4:ff:92 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    2852217530929 14728168893 0       20534741 0       0       
    RX errors: length   crc     frame   fifo    missed
               0        0       0       0       0       
    TX: bytes  packets  errors  dropped carrier collsns 
    3075478708351 14728042862 0       288633  0       0       
    TX errors: aborted  fifo   window heartbeat transns
               0        0       0       0       4       
NIC statistics:
     rx_packets: 14728168893
     tx_packets: 14728042862
     rx_bytes: 2852217530929
     tx_bytes: 3075478708351
     rx_errors: 0
     tx_errors: 0
     rx_dropped: 20534741
     tx_dropped: 0
     collisions: 0
     rx_length_errors: 0
     rx_crc_errors: 0
     rx_unicast: 14748703543
     tx_unicast: 14728042755
     rx_multicast: 0
     tx_multicast: 107
     rx_broadcast: 91
     tx_broadcast: 0
     rx_unknown_protocol: 0
     tx_linearize: 0
     tx_force_wb: 0
     tx_busy: 0
     rx_alloc_fail: 0
     rx_pg_alloc_fail: 0
     tx-0.packets: 577427417
     tx-0.bytes: 120244601497
     rx-0.packets: 575667058
     rx-0.bytes: 111515443606
     tx-1.packets: 575786193
     tx-1.bytes: 120254899619
     rx-1.packets: 575793020
     rx-1.bytes: 111521505780
     tx-2.packets: 574520864
     tx-2.bytes: 119992055692
     rx-2.packets: 574528748
     rx-2.bytes: 111281300958
     tx-3.packets: 575042156
     tx-3.bytes: 120100025123
     rx-3.packets: 575049278
     rx-3.bytes: 111378611664
     tx-4.packets: 574364669
     tx-4.bytes: 119959553442
     rx-4.packets: 574372066
     rx-4.bytes: 111250394512
     tx-5.packets: 575195522
     tx-5.bytes: 120132512941
     rx-5.packets: 575202303
     rx-5.bytes: 111409900268
     tx-6.packets: 575953516
     tx-6.bytes: 120289251534
     rx-6.packets: 575959536
     rx-6.bytes: 111552280682
     tx-7.packets: 575615417
     tx-7.bytes: 120219449298
     rx-7.packets: 575622286
     rx-7.bytes: 111489814755
     tx-8.packets: 576164920
     tx-8.bytes: 120334931533
     rx-8.packets: 576172689
     rx-8.bytes: 111597902230
     tx-9.packets: 575500697
     tx-9.bytes: 120197200963
     rx-9.packets: 575508748
     rx-9.bytes: 111472019210
     tx-10.packets: 576268040
     tx-10.bytes: 120295746688
     rx-10.packets: 577969463
     rx-10.bytes: 111661242716
     tx-11.packets: 575462315
     tx-11.bytes: 120187688849
     rx-11.packets: 575469189
     rx-11.bytes: 111460143920
     tx-12.packets: 575057232
     tx-12.bytes: 120103248572
     rx-12.packets: 575064140
     rx-12.bytes: 111382126446
     tx-13.packets: 574893558
     tx-13.bytes: 120070237936
     rx-13.packets: 574902092
     rx-13.bytes: 111353301419
     tx-14.packets: 575601267
     tx-14.bytes: 120217453928
     rx-14.packets: 575608841
     rx-14.bytes: 111489095131
     tx-15.packets: 574614915
     tx-15.bytes: 120011311066
     rx-15.packets: 574622645
     rx-15.bytes: 111297591956
     tx-16.packets: 575380622
     tx-16.bytes: 120175335270
     rx-16.packets: 575397288
     rx-16.bytes: 111477241108
     tx-17.packets: 573431714
     tx-17.bytes: 119597260502
     rx-17.packets: 573369245
     rx-17.bytes: 110619208164
     tx-18.packets: 545448400
     tx-18.bytes: 113923575542
     rx-18.packets: 545464770
     rx-18.bytes: 105678136977
     tx-19.packets: 546629895
     tx-19.bytes: 114170315319
     rx-19.packets: 546646643
     rx-19.bytes: 105907006937
     tx-20.packets: 545936594
     tx-20.bytes: 114025588574
     rx-20.packets: 545952214
     rx-20.bytes: 105772610572
     tx-21.packets: 545132327
     tx-21.bytes: 113857581190
     rx-21.packets: 545147567
     rx-21.bytes: 105616776562
     tx-22.packets: 547108078
     tx-22.bytes: 114270192796
     rx-22.packets: 547123800
     rx-22.bytes: 105999595717
     tx-23.packets: 547097838
     tx-23.bytes: 114268072685
     rx-23.packets: 547114573
     rx-23.bytes: 105997731963
     tx-24.packets: 547891080
     tx-24.bytes: 114433728353
     rx-24.packets: 547907315
     rx-24.bytes: 106151362599
     tx-25.packets: 546517616
     tx-25.bytes: 114146889439
     rx-25.packets: 546533376
     rx-25.bytes: 105885185077
     tx-26.packets: 0
     tx-26.bytes: 0
     rx-26.packets: 0
     rx-26.bytes: 0
     tx-27.packets: 0
     tx-27.bytes: 0
     rx-27.packets: 0
     rx-27.bytes: 0
     tx-28.packets: 0
     tx-28.bytes: 0
     rx-28.packets: 0
     rx-28.bytes: 0
     tx-29.packets: 0
     tx-29.bytes: 0
     rx-29.packets: 0
     rx-29.bytes: 0
     tx-30.packets: 0
     tx-30.bytes: 0
     rx-30.packets: 0
     rx-30.bytes: 0
     tx-31.packets: 0
     tx-31.bytes: 0
     rx-31.packets: 0
     rx-31.bytes: 0
     tx-32.packets: 0
     tx-32.bytes: 0
     rx-32.packets: 0
     rx-32.bytes: 0
     tx-33.packets: 0
     tx-33.bytes: 0
     rx-33.packets: 0
     rx-33.bytes: 0
     tx-34.packets: 0
     tx-34.bytes: 0
     rx-34.packets: 0
     rx-34.bytes: 0
     tx-35.packets: 0
     tx-35.bytes: 0
     rx-35.packets: 0
     rx-35.bytes: 0
     tx-36.packets: 0
     tx-36.bytes: 0
     rx-36.packets: 0
     rx-36.bytes: 0
     tx-37.packets: 0
     tx-37.bytes: 0
     rx-37.packets: 0
     rx-37.bytes: 0
     tx-38.packets: 0
     tx-38.bytes: 0
     rx-38.packets: 0
     rx-38.bytes: 0
     tx-39.packets: 0
     tx-39.bytes: 0
     rx-39.packets: 0
     rx-39.bytes: 0
     tx-40.packets: 0
     tx-40.bytes: 0
     rx-40.packets: 0
     rx-40.bytes: 0
     tx-41.packets: 0
     tx-41.bytes: 0
     rx-41.packets: 0
     rx-41.bytes: 0
     tx-42.packets: 0
     tx-42.bytes: 0
     rx-42.packets: 0
     rx-42.bytes: 0
     tx-43.packets: 0
     tx-43.bytes: 0
     rx-43.packets: 0
     rx-43.bytes: 0
     tx-44.packets: 0
     tx-44.bytes: 0
     rx-44.packets: 0
     rx-44.bytes: 0
     tx-45.packets: 0
     tx-45.bytes: 0
     rx-45.packets: 0
     rx-45.bytes: 0
     tx-46.packets: 0
     tx-46.bytes: 0
     rx-46.packets: 0
     rx-46.bytes: 0
     tx-47.packets: 0
     tx-47.bytes: 0
     rx-47.packets: 0
     rx-47.bytes: 0
     tx-48.packets: 0
     tx-48.bytes: 0
     rx-48.packets: 0
     rx-48.bytes: 0
     tx-49.packets: 0
     tx-49.bytes: 0
     rx-49.packets: 0
     rx-49.bytes: 0
     tx-50.packets: 0
     tx-50.bytes: 0
     rx-50.packets: 0
     rx-50.bytes: 0
     tx-51.packets: 0
     tx-51.bytes: 0
     rx-51.packets: 0
     rx-51.bytes: 0
     tx-52.packets: 0
     tx-52.bytes: 0
     rx-52.packets: 0
     rx-52.bytes: 0
     tx-53.packets: 0
     tx-53.bytes: 0
     rx-53.packets: 0
     rx-53.bytes: 0
     tx-54.packets: 0
     tx-54.bytes: 0
     rx-54.packets: 0
     rx-54.bytes: 0
     tx-55.packets: 0
     tx-55.bytes: 0
     rx-55.packets: 0
     rx-55.bytes: 0
     tx-56.packets: 0
     tx-56.bytes: 0
     rx-56.packets: 0
     rx-56.bytes: 0
     tx-57.packets: 0
     tx-57.bytes: 0
     rx-57.packets: 0
     rx-57.bytes: 0
     tx-58.packets: 0
     tx-58.bytes: 0
     rx-58.packets: 0
     rx-58.bytes: 0
     tx-59.packets: 0
     tx-59.bytes: 0
     rx-59.packets: 0
     rx-59.bytes: 0
     tx-60.packets: 0
     tx-60.bytes: 0
     rx-60.packets: 0
     rx-60.bytes: 0
     tx-61.packets: 0
     tx-61.bytes: 0
     rx-61.packets: 0
     rx-61.bytes: 0
     tx-62.packets: 0
     tx-62.bytes: 0
     rx-62.packets: 0
     rx-62.bytes: 0
     tx-63.packets: 0
     tx-63.bytes: 0
     rx-63.packets: 0
     rx-63.bytes: 0
     veb.rx_bytes: 0
     veb.tx_bytes: 0
     veb.rx_unicast: 0
     veb.tx_unicast: 0
     veb.rx_multicast: 0
     veb.tx_multicast: 0
     veb.rx_broadcast: 0
     veb.tx_broadcast: 0
     veb.rx_discards: 0
     veb.tx_discards: 0
     veb.tx_errors: 0
     veb.rx_unknown_protocol: 0
     veb.tc_0_tx_packets: 0
     veb.tc_0_tx_bytes: 0
     veb.tc_0_rx_packets: 0
     veb.tc_0_rx_bytes: 0
     veb.tc_1_tx_packets: 0
     veb.tc_1_tx_bytes: 0
     veb.tc_1_rx_packets: 0
     veb.tc_1_rx_bytes: 0
     veb.tc_2_tx_packets: 0
     veb.tc_2_tx_bytes: 0
     veb.tc_2_rx_packets: 0
     veb.tc_2_rx_bytes: 0
     veb.tc_3_tx_packets: 0
     veb.tc_3_tx_bytes: 0
     veb.tc_3_rx_packets: 0
     veb.tc_3_rx_bytes: 0
     veb.tc_4_tx_packets: 0
     veb.tc_4_tx_bytes: 0
     veb.tc_4_rx_packets: 0
     veb.tc_4_rx_bytes: 0
     veb.tc_5_tx_packets: 0
     veb.tc_5_tx_bytes: 0
     veb.tc_5_rx_packets: 0
     veb.tc_5_rx_bytes: 0
     veb.tc_6_tx_packets: 0
     veb.tc_6_tx_bytes: 0
     veb.tc_6_rx_packets: 0
     veb.tc_6_rx_bytes: 0
     veb.tc_7_tx_packets: 0
     veb.tc_7_tx_bytes: 0
     veb.tc_7_rx_packets: 0
     veb.tc_7_rx_bytes: 0
     port.rx_bytes: 2915198153465
     port.tx_bytes: 3134390426425
     port.rx_unicast: 14748703543
     port.tx_unicast: 14728042755
     port.rx_multicast: 0
     port.tx_multicast: 1733
     port.rx_broadcast: 91
     port.tx_broadcast: 0
     port.tx_errors: 0
     port.rx_dropped: 0
     port.tx_dropped_link_down: 0
     port.rx_crc_errors: 0
     port.illegal_bytes: 0
     port.mac_local_faults: 0
     port.mac_remote_faults: 0
     port.tx_timeout: 0
     port.rx_csum_bad: 0
     port.rx_length_errors: 0
     port.link_xon_rx: 0
     port.link_xoff_rx: 0
     port.link_xon_tx: 0
     port.link_xoff_tx: 0
     port.rx_size_64: 66000
     port.rx_size_127: 4722761160
     port.rx_size_255: 8922472006
     port.rx_size_511: 802459410
     port.rx_size_1023: 200631237
     port.rx_size_1522: 100313821
     port.rx_size_big: 0
     port.tx_size_64: 59983
     port.tx_size_127: 1907997459
     port.tx_size_255: 8513287767
     port.tx_size_511: 4206485860
     port.tx_size_1023: 745
     port.tx_size_1522: 100212674
     port.tx_size_big: 0
     port.rx_undersize: 0
     port.rx_fragments: 0
     port.rx_oversize: 0
     port.rx_jabber: 0
     port.VF_admin_queue_requests: 0
     port.arq_overflows: 0
     port.tx_hwtstamp_timeouts: 0
     port.rx_hwtstamp_cleared: 0
     port.tx_hwtstamp_skipped: 0
     port.fdir_flush_cnt: 252
     port.fdir_atr_match: 831631514
     port.fdir_atr_tunnel_match: 0
     port.fdir_atr_status: 1
     port.fdir_sb_match: 0
     port.fdir_sb_status: 1
     port.tx_lpi_status: 0
     port.rx_lpi_status: 0
     port.tx_lpi_count: 0
     port.rx_lpi_count: 0
     port.tx_priority_0_xon_tx: 0
     port.tx_priority_0_xoff_tx: 0
     port.rx_priority_0_xon_rx: 0
     port.rx_priority_0_xoff_rx: 0
     port.rx_priority_0_xon_2_xoff: 0
     port.tx_priority_1_xon_tx: 0
     port.tx_priority_1_xoff_tx: 0
     port.rx_priority_1_xon_rx: 0
     port.rx_priority_1_xoff_rx: 0
     port.rx_priority_1_xon_2_xoff: 0
     port.tx_priority_2_xon_tx: 0
     port.tx_priority_2_xoff_tx: 0
     port.rx_priority_2_xon_rx: 0
     port.rx_priority_2_xoff_rx: 0
     port.rx_priority_2_xon_2_xoff: 0
     port.tx_priority_3_xon_tx: 0
     port.tx_priority_3_xoff_tx: 0
     port.rx_priority_3_xon_rx: 0
     port.rx_priority_3_xoff_rx: 0
     port.rx_priority_3_xon_2_xoff: 0
     port.tx_priority_4_xon_tx: 0
     port.tx_priority_4_xoff_tx: 0
     port.rx_priority_4_xon_rx: 0
     port.rx_priority_4_xoff_rx: 0
     port.rx_priority_4_xon_2_xoff: 0
     port.tx_priority_5_xon_tx: 0
     port.tx_priority_5_xoff_tx: 0
     port.rx_priority_5_xon_rx: 0
     port.rx_priority_5_xoff_rx: 0
     port.rx_priority_5_xon_2_xoff: 0
     port.tx_priority_6_xon_tx: 0
     port.tx_priority_6_xoff_tx: 0
     port.rx_priority_6_xon_rx: 0
     port.rx_priority_6_xoff_rx: 0
     port.rx_priority_6_xon_2_xoff: 0
     port.tx_priority_7_xon_tx: 0
     port.tx_priority_7_xoff_tx: 0
     port.rx_priority_7_xon_rx: 0
     port.rx_priority_7_xoff_rx: 0
     port.rx_priority_7_xon_2_xoff: 0
jhs at SUT:~/new-proto$ 

