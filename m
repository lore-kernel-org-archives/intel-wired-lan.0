From: Fan Du <fengyuleidian0615@gmail.com>
Date: Thu, 02 Apr 2015 11:56:19 +0800
Subject: [Intel-wired-lan] Fragmented UDP packets trigger rx_missed_errors
	on 82599EB
Message-ID: <551CBDE3.30708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi

While investigating a upper level network issue, I found out the root cause may be triggered
by packet loss at NIC level, showed by rx_missed_errors.

kernel: linux-2.6.32-358.el6.x86_64
server: iperf -s -B 192.168.5.1 -u
client: iperf -c 192.168.5.1 -u -b 10G -i 1 -t 1000 -P 12 -l 3k
Use -l to specify buffers large than MTU to create fragmented IP packets.

1. Tune rx ring from 512 to max 4096 does help for single flow, but still got great rx_missed_errors from multiple flows.
2. Using latest net-next 4.0.0-rc4 shows the same effect.
3. Got 9.4Gbits/sec even though rx_missed_errors shows NIC level packets drop.

rx_missed_errors value comes from RXMPC, where 82599 data sheet 8.2.3.5.1 says:
"Missed packet interrupt is activated for each received packet that overflows the Rx
packet buffer (overrun).
he packet is dropped and also increments the associated RXMPC[n] counter."

I'm not sure it means my env is mis-configured or anything I'm missing obviously.
Any hints?

Attached several logs as below.
# ethtool -S eth4
NIC statistics:
rx_packets: 1047869017
tx_packets: 206275776
rx_bytes: 1103333268576
tx_bytes: 289198212456
rx_pkts_nic: 1047200292
tx_pkts_nic: 206275773
rx_bytes_nic: 1907927064202
tx_bytes_nic: 290023317512
lsc_int: 17
tx_busy: 0
non_eop_descs: 0
rx_errors: 0
tx_errors: 0
rx_dropped: 0
tx_dropped: 0
multicast: 0
broadcast: 4310
rx_no_buffer_count: 0
collisions: 0
rx_over_errors: 0
rx_crc_errors: 0
rx_frame_errors: 0
hw_rsc_aggregated: 0
hw_rsc_flushed: 0
fdir_match: 0
fdir_miss: 6545204
fdir_overflow: 0
rx_fifo_errors: 0
rx_missed_errors: 638609576 <--------
tx_aborted_errors: 0
tx_carrier_errors: 0
tx_fifo_errors: 0
tx_heartbeat_errors: 0
tx_timeout_count: 0
tx_restart_queue: 0
rx_long_length_errors: 0
rx_short_length_errors: 0
tx_flow_control_xon: 174182
rx_flow_control_xon: 0
tx_flow_control_xoff: 946044

# numactl --hardware
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 20 21 22 23 24
node 0 size: 24466 MB
node 0 free: 22444 MB
node 1 cpus: 5 6 7 8 9 25 26 27 28 29
node 1 size: 16384 MB
node 1 free: 15831 MB
node 2 cpus: 10 11 12 13 14 30 31 32 33 34
node 2 size: 16384 MB
node 2 free: 15791 MB
node 3 cpus: 15 16 17 18 19 35 36 37 38 39
node 3 size: 24576 MB
node 3 free: 22508 MB
node distances:
node 0 1 2 3
0: 10 21 31 31
1: 21 10 31 31
2: 31 31 10 21
3: 31 31 21 10


# ethtool -g eth4
Ring parameters for eth4:
Pre-set maximums:
RX: 4096
RX Mini: 0
RX Jumbo: 0
TX: 4096
Current hardware settings:
RX: 4096 <---- I tweak it from 512 to max 4096, it helps for single flow, but still not good for multiple flows.
RX Mini: 0
RX Jumbo: 0
TX: 512

# ethtool -a eth4
Pause parameters for eth4:
Autonegotiate: on
RX: on
TX: on

# ethtool -c eth4
Coalesce parameters for eth4:
Adaptive RX: off TX: off
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 1
rx-frames: 0
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 0
tx-frames: 0
tx-usecs-irq: 0
tx-frames-irq: 0

rx-usecs-low: 0
rx-frame-low: 0
tx-usecs-low: 0
tx-frame-low: 0

rx-usecs-high: 0
rx-frame-high: 0
tx-usecs-high: 0
tx-frame-high: 0


# lspci -vv (Assuming I'm using 84:00.0)
84:00.0 Ethernet controller: Intel Corporation 82599EB 10-Gigabit SFI/SFP+ Network Connection (rev 01)
Subsystem: Intel Corporation Ethernet Server Adapter X520-2
Physical Slot: 803
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 66
Region 0: Memory at 387fffb80000 (64-bit, prefetchable) [size=512K]
Region 2: I/O ports at 8020 [size=32]
Region 4: Memory at 387fffc04000 (64-bit, prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
Address: 0000000000000000 Data: 0000
Masking: 00000000 Pending: 00000000
Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00002000
Capabilities: [a0] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr+ UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #2, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 <1us, L1 <8us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO+ CmpltAbrt+ UnxCmplt+ RxOF+ MalfTLP+ ECRC+ UnsupReq+ ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Device Serial Number 90-e2-ba-ff-ff-50-8d-f0
Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
ARICap: MFVC- ACS-, Next Function: 1
ARICtl: MFVC- ACS-, Function Group: 0
Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
IOVCap: Migration-, Interrupt Message Number: 000
IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
IOVSta: Migration-
Initial VFs: 64, Total VFs: 64, Number of VFs: 64, Function Dependency Link: 00
VF offset: 128, stride: 2, Device ID: 10ed
Supported Page Size: 00000553, System Page Size: 00000001
Region 0: Memory at 00000000c8000000 (64-bit, non-prefetchable)
Region 3: Memory@00000000c8100000 (64-bit, non-prefetchable)
VF Migration: offset: 00000000, BIR: 0
Kernel driver in use: ixgbe
Kernel modules: ixgbe

84:00.1 Ethernet controller: Intel Corporation 82599EB 10-Gigabit SFI/SFP+ Network Connection (rev 01)
Subsystem: Intel Corporation Ethernet Server Adapter X520-2
Physical Slot: 803
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 69
Region 0: Memory at 387fffb00000 (64-bit, prefetchable) [size=512K]
Region 2: I/O ports at 8000 [size=32]
Region 4: Memory at 387fffc00000 (64-bit, prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
Address: 0000000000000000 Data: 0000
Masking: 00000000 Pending: 00000000
Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00002000
Capabilities: [a0] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr+ UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #2, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 <1us, L1 <8us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO+ CmpltAbrt+ UnxCmplt+ RxOF+ MalfTLP+ ECRC+ UnsupReq+ ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [140 v1] Device Serial Number 90-e2-ba-ff-ff-50-8d-f0
Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
ARICap: MFVC- ACS-, Next Function: 0
ARICtl: MFVC- ACS-, Function Group: 0
Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
IOVCap: Migration-, Interrupt Message Number: 000
IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
IOVSta: Migration-
Initial VFs: 64, Total VFs: 64, Number of VFs: 64, Function Dependency Link: 01
VF offset: 128, stride: 2, Device ID: 10ed
Supported Page Size: 00000553, System Page Size: 00000001
Region 0: Memory at 00000000c8200000 (64-bit, non-prefetchable)
Region 3: Memory@00000000c8300000 (64-bit, non-prefetchable)
VF Migration: offset: 00000000, BIR: 0
Kernel driver in use: ixgbe
Kernel modules: ixgbe



# lspci -t
-+-[0000:ff]-+-08.0
| +-08.2
| +-08.3
| +-09.0
| +-09.2
| +-09.3
| +-0b.0
| +-0b.1
| +-0b.2
| +-0c.0
| +-0c.1
| +-0c.2
| +-0c.3
| +-0c.4
| +-0c.5
| +-0c.6
| +-0c.7
| +-0d.0
| +-0d.1
| +-0f.0
| +-0f.1
| +-0f.2
| +-0f.3
| +-0f.4
| +-0f.5
| +-0f.6
| +-10.0
| +-10.1
| +-10.5
| +-10.6
| +-10.7
| +-12.0
| +-12.1
| +-12.4
| +-12.5
| +-13.0
| +-13.1
| +-13.2
| +-13.3
| +-13.6
| +-13.7
| +-14.0
| +-14.1
| +-14.2
| +-14.3
| +-14.4
| +-14.5
| +-14.6
| +-14.7
| +-16.0
| +-16.1
| +-16.2
| +-16.3
| +-16.6
| +-16.7
| +-17.0
| +-17.1
| +-17.2
| +-17.3
| +-17.4
| +-17.5
| +-17.6
| +-17.7
| +-1e.0
| +-1e.1
| +-1e.2
| +-1e.3
| +-1e.4
| +-1f.0
| \-1f.2
+-[0000:80]-+-01.0-[81-82]--+-00.0
| | \-00.1
| +-03.0-[83]--
| +-03.2-[84-85]--+-00.0
| | \-00.1
| +-04.0
| +-04.1
| +-04.2
| +-04.3
| +-04.4
| +-04.5
| +-04.6
| +-04.7
| +-05.0
| +-05.1
| +-05.2
| \-05.4
+-[0000:7f]-+-08.0
| +-08.2
| +-08.3
| +-09.0
| +-09.2
| +-09.3
| +-0b.0
| +-0b.1
| +-0b.2
| +-0c.0
| +-0c.1
| +-0c.2
| +-0c.3
| +-0c.4
| +-0c.5
| +-0c.6
| +-0c.7
| +-0d.0
| +-0d.1
| +-0f.0
| +-0f.1
| +-0f.2
| +-0f.3
| +-0f.4
| +-0f.5
| +-0f.6
| +-10.0
| +-10.1
| +-10.5
| +-10.6
| +-10.7
| +-12.0
| +-12.1
| +-12.4
| +-12.5
| +-13.0
| +-13.1
| +-13.2
| +-13.3
| +-13.6
| +-13.7
| +-14.0
| +-14.1
| +-14.2
| +-14.3
| +-14.4
| +-14.5
| +-14.6
| +-14.7
| +-16.0
| +-16.1
| +-16.2
| +-16.3
| +-16.6
| +-16.7
| +-17.0
| +-17.1
| +-17.2
| +-17.3
| +-17.4
| +-17.5
| +-17.6
| +-17.7
| +-1e.0
| +-1e.1
| +-1e.2
| +-1e.3
| +-1e.4
| +-1f.0
| \-1f.2
\-[0000:00]-+-00.0
+-01.0-[01]--
+-02.0-[02]--
+-02.2-[03-04]--+-00.0
| \-00.1
+-03.0-[05]--
+-03.2-[06]--
+-04.0
+-04.1
+-04.2
+-04.3
+-04.4
+-04.5
+-04.6
+-04.7
+-05.0
+-05.1
+-05.2
+-05.4
+-11.0
+-11.4
+-14.0
+-16.0
+-16.1
+-1a.0
+-1c.0-[07]----00.0
+-1d.0
+-1f.0
+-1f.2
\-1f.3

-- 
????????????????
????????????????

