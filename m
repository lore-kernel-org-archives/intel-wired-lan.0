From: Diego Rodriguez Gonzalez <gran.diego@gmail.com>
Date: Wed, 18 May 2016 14:34:31 +0200
Subject: [Intel-wired-lan] [PROBLEM] e1000e driver failed with error -3
In-Reply-To: <573C588B.8040402@gmail.com>
References: <573C588B.8040402@gmail.com>
Message-ID: <573C6157.3040007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


[1.]
On cold boot, e1000e fails with error -3. On reboot, works fine

[2.]
Failure to load e1000e on cold boot render network card unusable. After
reboot, module loads with no error and network card works properly.

[3.]
e1000e

[4.]
Linux version 4.6.0-040600-generic (kernel at gomeisa) (gcc version 5.3.1
20160509 (Ubuntu 5.3.1-19ubuntu1) ) #201605151930 SMP Sun May 15
23:32:59 UTC 2016

[7.2.]
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Celeron(R) CPU 2950M @ 2.00GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 1081.640
cache size    : 2048 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer xsave rdrand lahf_lm abm epb tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust erms invpcid xsaveopt dtherm
arat pln pts
bugs        :
bogomips    : 3991.10
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 60
model name    : Intel(R) Celeron(R) CPU 2950M @ 2.00GHz
stepping    : 3
microcode    : 0x1e
cpu MHz        : 893.828
cache size    : 2048 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
popcnt tsc_deadline_timer xsave rdrand lahf_lm abm epb tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust erms invpcid xsaveopt dtherm
arat pln pts
bugs        :
bogomips    : 3992.00
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

[7.3.]
drbg 32768 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
ctr 16384 2 - Live 0x0000000000000000
ccm 20480 2 - Live 0x0000000000000000
rpcsec_gss_krb5 36864 0 - Live 0x0000000000000000
auth_rpcgss 61440 1 rpcsec_gss_krb5, Live 0x0000000000000000
nfsv4 552960 1 - Live 0x0000000000000000
nfs 258048 3 nfsv4, Live 0x0000000000000000
lockd 94208 1 nfs, Live 0x0000000000000000
grace 16384 1 lockd, Live 0x0000000000000000
fscache 61440 2 nfsv4,nfs, Live 0x0000000000000000
toshiba_acpi 45056 0 - Live 0x0000000000000000
sparse_keymap 16384 1 toshiba_acpi, Live 0x0000000000000000
toshiba_haps 16384 0 - Live 0x0000000000000000
hp_accel 28672 0 - Live 0x0000000000000000
lis3lv02d 20480 1 hp_accel, Live 0x0000000000000000
input_polldev 16384 1 lis3lv02d, Live 0x0000000000000000
pci_stub 16384 1 - Live 0x0000000000000000
vboxpci 24576 0 - Live 0x0000000000000000 (OE)
vboxnetadp 28672 0 - Live 0x0000000000000000 (OE)
vboxnetflt 28672 0 - Live 0x0000000000000000 (OE)
vboxdrv 487424 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x0000000000000000 (OE)
binfmt_misc 20480 1 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
kvm_intel 192512 0 - Live 0x0000000000000000
kvm 569344 1 kvm_intel, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
videodev 180224 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
bluetooth 520192 5 btusb,btrtl,btbcm,btintel, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
cryptd 20480 1 ghash_clmulni_intel, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
rtl8723be 86016 0 - Live 0x0000000000000000
snd_hda_codec_via 24576 1 - Live 0x0000000000000000
btcoexist 53248 1 rtl8723be, Live 0x0000000000000000
rtl8723_common 24576 1 rtl8723be, Live 0x0000000000000000
rtl_pci 28672 1 rtl8723be, Live 0x0000000000000000
snd_hda_codec_generic 73728 1 snd_hda_codec_via, Live 0x0000000000000000
snd_hda_intel 36864 5 - Live 0x0000000000000000
rtlwifi 77824 2 rtl8723be,rtl_pci, Live 0x0000000000000000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_via,snd_hda_codec_generic,snd_hda_intel, Live
0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
mac80211 745472 3 rtl8723be,rtl_pci,rtlwifi, Live 0x0000000000000000
snd_hda_core 81920 5
snd_hda_codec_hdmi,snd_hda_codec_via,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm_oss 49152 0 - Live 0x0000000000000000
cfg80211 581632 2 rtlwifi,mac80211, Live 0x0000000000000000
snd_mixer_oss 24576 1 snd_pcm_oss, Live 0x0000000000000000
snd_pcm 110592 5
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core,snd_pcm_oss,
Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd 81920 23
snd_hda_codec_hdmi,snd_hda_codec_via,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
tpm_infineon 20480 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
8250_fintek 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
ie31200_edac 16384 0 - Live 0x0000000000000000
intel_smartconnect 16384 0 - Live 0x0000000000000000
edac_core 53248 1 ie31200_edac, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
sunrpc 339968 12 rpcsec_gss_krb5,auth_rpcgss,nfsv4,nfs,lockd, Live
0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
msr 16384 0 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
btrfs 1019904 0 - Live 0x0000000000000000
xor 24576 1 btrfs, Live 0x0000000000000000
raid6_pq 102400 1 btrfs, Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 118784 2 hid_generic,usbhid, Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
rtsx_pci 53248 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
wmi 20480 1 toshiba_acpi, Live 0x0000000000000000
e1000e 237568 0 - Live 0x0000000000000000
i915 1269760 4 - Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
video 40960 2 toshiba_acpi,i915, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 147456 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
drm 364544 5 i915,drm_kms_helper, Live 0x0000000000000000

[7.4.]
/proc/ioports
0000-0000 : PCI Bus 0000:00
    0000-0000 : dma1
    0000-0000 : pic1
    0000-0000 : timer0
    0000-0000 : timer1
    0000-0000 : keyboard
    0000-0000 : PNP0C09:00
      0000-0000 : EC data
    0000-0000 : keyboard
    0000-0000 : PNP0C09:00
      0000-0000 : EC cmd
    0000-0000 : rtc0
    0000-0000 : dma page reg
    0000-0000 : pic2
    0000-0000 : dma2
    0000-0000 : fpu
      0000-0000 : PNP0C04:00
    0000-0000 : vesafb
    0000-0000 : serial
    0000-0000 : pnp 00:07
    0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
    0000-0000 : pnp 00:01
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI CPU throttle
    0000-0000 : ACPI GPE0_BLK
    0000-0000 : iTCO_wdt.0.auto
    0000-0000 : ACPI PM2_CNT_BLK
    0000-0000 : pnp 00:03
    0000-0000 : iTCO_wdt.0.auto
    0000-0000 : pnp 00:01
    0000-0000 : pnp 00:01
    0000-0000 : pnp 00:01
    0000-0000 : pnp 00:01
    0000-0000 : PCI Bus 0000:04
    0000-0000 : PCI Bus 0000:02
      0000-0000 : 0000:02:00.0
        0000-0000 : rtl_pci
    0000-0000 : 0000:00:02.0
    0000-0000 : 0000:00:1f.3
    0000-0000 : 0000:00:1f.2
      0000-0000 : ahci
    0000-0000 : 0000:00:19.0
    0000-0000 : 0000:00:1f.2
      0000-0000 : ahci
    0000-0000 : 0000:00:1f.2
      0000-0000 : ahci
    0000-0000 : 0000:00:1f.2
      0000-0000 : ahci
    0000-0000 : 0000:00:1f.2
      0000-0000 : ahci
    0000-0000 : pnp 00:01
      0000-0000 : pnp 00:01
        0000-0000 : pnp 00:01

iomem

00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : Video ROM
00000000-00000000 : Adapter ROM
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : reserved
    00000000-00000000 : PCI Bus 0000:00
    00000000-00000000 : PCI Bus 0000:00
    00000000-00000000 : System ROM
00000000-00000000 : System RAM
    00000000-00000000 : Kernel code
    00000000-00000000 : Kernel data
    00000000-00000000 : Kernel bss
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
    00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
    00000000-00000000 : 0000:00:02.0
    00000000-00000000 : PCI Bus 0000:04
    00000000-00000000 : 0000:00:02.0
    00000000-00000000 : PCI Bus 0000:04
    00000000-00000000 : PCI Bus 0000:03
      00000000-00000000 : 0000:03:00.0
        00000000-00000000 : rtsx_pci
    00000000-00000000 : PCI Bus 0000:02
      00000000-00000000 : 0000:02:00.0
        00000000-00000000 : rtl_pci
    00000000-00000000 : 0000:00:19.0
    00000000-00000000 : 0000:00:14.0
      00000000-00000000 : xhci-hcd
    00000000-00000000 : 0000:00:1b.0
      00000000-00000000 : ICH HD audio
    00000000-00000000 : 0000:00:03.0
      00000000-00000000 : ICH HD audio
    00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : 0000:00:1f.2
      00000000-00000000 : ahci
    00000000-00000000 : 0000:00:1d.0
      00000000-00000000 : ehci_hcd
    00000000-00000000 : 0000:00:1a.0
      00000000-00000000 : ehci_hcd
    00000000-00000000 : 0000:00:19.0
    00000000-00000000 : pnp 00:08
    00000000-00000000 : pnp 00:08
    00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
      00000000-00000000 : reserved
        00000000-00000000 : pnp 00:08
00000000-00000000 : reserved
    00000000-00000000 : IOAPIC 0
00000000-00000000 : reserved
    00000000-00000000 : HPET 0
      00000000-00000000 : PNP0103:00
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:08
00000000-00000000 : reserved
    00000000-00000000 : pnp 00:08
      00000000-00000000 : iTCO_wdt.0.auto
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:08
00000000-00000000 : Local APIC
    00000000-00000000 : reserved
00000000-00000000 : reserved
    00000000-00000000 : INT0800:00
      00000000-00000000 : pnp 00:08
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer

[7.5.]
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor DRAM Controller (rev 06)
      Subsystem: CLEVO/KAPOK Computer Xeon E3-1200 v3/4th Gen Core
Processor DRAM Controller
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
      Latency: 0
      Capabilities: [e0] Vendor Specific Information: Len=0c <?>
      Kernel modules: ie31200_edac

00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
controller])
      Subsystem: CLEVO/KAPOK Computer 4th Gen Core Processor Integrated
Graphics Controller
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 25
      Region 0: Memory at f6c00000 (64-bit, non-prefetchable) [size=4M]
      Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
      Region 4: I/O ports at f000 [size=64]
      [virtual] Expansion ROM@000c0000 [disabled] [size=128K]
      Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
          Address: fee0200c  Data: 4142
      Capabilities: [d0] Power Management version 2
          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [a4] PCI Advanced Features
          AFCap: TP+ FLR+
          AFCtrl: FLR-
          AFStatus: TP-
      Kernel driver in use: i915
      Kernel modules: i915

00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller (rev 06)
      Subsystem: CLEVO/KAPOK Computer Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 29
      Region 0: Memory@f7c34000 (64-bit, non-prefetchable) [size=16K]
      Capabilities: [50] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
          Address: fee0200c  Data: 4182
      Capabilities: [70] Express (v1) Root Complex Integrated Endpoint,
MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0
              ExtTag- RBE-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
      Kernel driver in use: snd_hda_intel
      Kernel modules: snd_hda_intel

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB xHCI (rev 05) (prog-if 30 [XHCI])
      Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset Family
USB xHCI
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 24
      Region 0: Memory@f7c20000 (64-bit, non-prefetchable) [size=64K]
      Capabilities: [70] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
          Address: 00000000fee0200c  Data: 41c1
      Kernel driver in use: xhci_hcd

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection
I217-LM (rev 05)
      Subsystem: Intel Corporation Ethernet Connection I217-LM
      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Interrupt: pin A routed to IRQ 20
      Region 0: Memory at f7c00000 (32-bit, non-prefetchable) [size=128K]
      Region 1: Memory at f7c3d000 (32-bit, non-prefetchable) [size=4K]
      Region 2: I/O ports@f080 [size=32]
      Capabilities: [c8] Power Management version 2
          Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
      Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
          Address: 0000000000000000  Data: 0000
      Capabilities: [e0] PCI Advanced Features
          AFCap: TP+ FLR+
          AFCtrl: FLR-
          AFStatus: TP-
      Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
      Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset Family
USB EHCI
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 16
      Region 0: Memory@f7c3c000 (32-bit, non-prefetchable) [size=1K]
      Capabilities: [50] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [58] Debug port: BAR=1 offset=00a0
      Capabilities: [98] PCI Advanced Features
          AFCap: TP+ FLR+
          AFCtrl: FLR-
          AFStatus: TP-
      Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
High Definition Audio Controller (rev 05)
      Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset High
Definition Audio Controller
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 28
      Region 0: Memory@f7c30000 (64-bit, non-prefetchable) [size=16K]
      Capabilities: [50] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
          Address: 00000000fee0200c  Data: 4172
      Capabilities: [70] Express (v1) Root Complex Integrated Endpoint,
MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0
              ExtTag- RBE-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
      Capabilities: [100 v1] Virtual Channel
          Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
          Arb:    Fixed- WRR32- WRR64- WRR128-
          Ctrl:    ArbSelect=Fixed
          Status:    InProgress-
          VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
              Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
              Status:    NegoPending- InProgress-
          VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
              Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
              Ctrl:    Enable+ ID=2 ArbSelect=Fixed TC/VC=04
              Status:    NegoPending- InProgress-
      Kernel driver in use: snd_hda_intel
      Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 16
      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
      I/O behind bridge: 0000f000-00000fff
      Memory behind bridge: fff00000-000fffff
      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0
              ExtTag- RBE+
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
              ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
          RootCap: CRSVisible-
          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF
Via WAKE# ARIFwd-
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Capabilities: [90] Subsystem: CLEVO/KAPOK Computer 8 Series/C220
Series Chipset Family PCI Express Root Port
      Capabilities: [a0] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Kernel driver in use: pcieport
      Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin C routed to IRQ 18
      Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
      I/O behind bridge: 0000e000-0000efff
      Memory behind bridge: f7b00000-f7bfffff
      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0
              ExtTag- RBE+
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
              ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
              Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
              Changed: MRL- PresDet- LinkState-
          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
          RootCap: CRSVisible-
          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Capabilities: [90] Subsystem: CLEVO/KAPOK Computer 8 Series/C220
Series Chipset Family PCI Express Root Port
      Capabilities: [a0] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Kernel driver in use: pcieport
      Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #4 (rev d5) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin D routed to IRQ 19
      Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
      I/O behind bridge: 0000f000-00000fff
      Memory behind bridge: f7a00000-f7afffff
      Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0
              ExtTag- RBE+
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <16us
              ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
              Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
              Changed: MRL- PresDet- LinkState-
          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
          RootCap: CRSVisible-
          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
          LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Capabilities: [90] Subsystem: CLEVO/KAPOK Computer 8 Series/C220
Series Chipset Family PCI Express Root Port
      Capabilities: [a0] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Kernel driver in use: pcieport
      Kernel modules: shpchp

00:1c.5 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #6 (rev d5) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin B routed to IRQ 17
      Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
      I/O behind bridge: 0000d000-0000dfff
      Memory behind bridge: f7000000-f79fffff
      Prefetchable memory behind bridge: 00000000f0000000-00000000f09fffff
      Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
      BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
          PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
      Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0
              ExtTag- RBE+
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 128 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
          LnkCap:    Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <16us
              ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
          SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
              Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
          SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
              Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
          SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
              Changed: MRL- PresDet- LinkState-
          RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
          RootCap: CRSVisible-
          RootSta: PME ReqID 0000, PMEStatus- PMEPending-
          DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
          Address: 00000000  Data: 0000
      Capabilities: [90] Subsystem: CLEVO/KAPOK Computer 8 Series/C220
Series Chipset Family PCI Express Root Port
      Capabilities: [a0] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Kernel driver in use: pcieport
      Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
      Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset Family
USB EHCI
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin A routed to IRQ 23
      Region 0: Memory@f7c3b000 (32-bit, non-prefetchable) [size=1K]
      Capabilities: [50] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [58] Debug port: BAR=1 offset=00a0
      Capabilities: [98] PCI Advanced Features
          AFCap: TP+ FLR+
          AFCtrl: FLR-
          AFStatus: TP-
      Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QM87 Express LPC Controller (rev 05)
      Subsystem: CLEVO/KAPOK Computer QM87 Express LPC Controller
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Capabilities: [e0] Vendor Specific Information: Len=0c <?>
      Kernel driver in use: lpc_ich
      Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset
Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
      Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset Family
6-port SATA Controller 1 [AHCI mode]
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0
      Interrupt: pin B routed to IRQ 27
      Region 0: I/O ports at f0d0 [size=8]
      Region 1: I/O ports at f0c0 [size=4]
      Region 2: I/O ports at f0b0 [size=8]
      Region 3: I/O ports at f0a0 [size=4]
      Region 4: I/O ports at f060 [size=32]
      Region 5: Memory@f7c3a000 (32-bit, non-prefetchable) [size=2K]
      Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
          Address: fee0200c  Data: 4152
      Capabilities: [70] Power Management version 3
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
      Kernel driver in use: ahci
      Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller (rev 05)
      Subsystem: CLEVO/KAPOK Computer 8 Series/C220 Series Chipset Family
SMBus Controller
      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Interrupt: pin C routed to IRQ 3
      Region 0: Memory at f7c39000 (64-bit, non-prefetchable) [size=256]
      Region 4: I/O ports@f040 [size=32]
      Kernel modules: i2c_i801

02:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE
PCIe Wireless Network Adapter
      Subsystem: Realtek Semiconductor Co., Ltd. RTL8723BE PCIe Wireless
Network Adapter
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 18
      Region 0: I/O ports at e000 [size=256]
      Region 2: Memory@f7b00000 (64-bit, non-prefetchable) [size=16K]
      Capabilities: [40] Power Management version 3
          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
          Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
          Address: 0000000000000000  Data: 0000
      Capabilities: [70] Express (v2) Endpoint, MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,
L1 <64us
              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 512 bytes
          DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <64us
              ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
          LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
          DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+,
OBFF Via message/WAKE#
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-,
OBFF Disabled
          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [100 v2] Advanced Error Reporting
          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
          CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
      Capabilities: [140 v1] Device Serial Number 00-23-b7-fe-ff-4c-e0-00
      Capabilities: [150 v1] Latency Tolerance Reporting
          Max snoop latency: 71680ns
          Max no snoop latency: 71680ns
      Capabilities: [158 v1] L1 PM Substates
          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
                PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
      Kernel driver in use: rtl8723be
      Kernel modules: rtl8723be

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5229
PCI Express Card Reader (rev 01)
      Subsystem: CLEVO/KAPOK Computer RTS5229 PCI Express Card Reader
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
      Latency: 0, Cache Line Size: 64 bytes
      Interrupt: pin A routed to IRQ 26
      Region 0: Memory@f7a00000 (32-bit, non-prefetchable) [size=4K]
      Capabilities: [40] Power Management version 3
          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
          Address: 00000000fee0300c  Data: 4122
      Capabilities: [70] Express (v2) Endpoint, MSI 00
          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
              ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
              RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
              MaxPayload 128 bytes, MaxReadReq 512 bytes
          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 <64us
              ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
              ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
          DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-,
OBFF Not Supported
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
          LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
               Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
               Compliance De-emphasis: -6dB
          LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
               EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
      Capabilities: [100 v1] Advanced Error Reporting
          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
          UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
          CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
          AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
      Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
      Kernel driver in use: rtsx_pci
      Kernel modules: rtsx_pci

[7.6.]
Attached devices:
Host: scsi5 Channel: 00 Id: 00 Lun: 00
    Vendor: ATA      Model: HGST HTS725050A7 Rev: A420
    Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.]

   dmesg | grep e1000e
[    1.288357] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.288360] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.288534] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec)
set to dynamic conservative mode
[    2.301150] e1000e: probe of 0000:00:19.0 failed with error -3

More info at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1576953

Best regards,
Diego






-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3589 bytes
Desc: Firma criptogr??fica S/MIME
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160518/7b794596/attachment-0001.p7s>
