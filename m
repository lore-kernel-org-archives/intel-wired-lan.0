From: Francesco Raviglione <francescorav.es483@gmail.com>
Date: Fri, 26 Jul 2019 12:01:36 +0200
Subject: [Intel-wired-lan] PROBLEM: No hardware receive timestamps are
 returned when using ETH_P_ALL raw sockets and Intel NICs
Message-ID: <CAMSq+bg3-VdXvy=XRnTeunMMfL2mp_0HRPeGjvzTU1JA_bRjrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,
I do not know if this is the right place to report a possible issue, but I
was not able to find another list related to the problem I am experiencing.
I am currently using two different hardware devices, using two different
Intel drivers (e1000e - system 1 - and igb - system 2 -) and the problem is
occuring in both.
Here is a compiled bug reporting form:

[1.] One line summary of the problem:
No hardware receive timestamps are returned when using ETH_P_ALL raw
sockets and Intel NICs

[2.] Full description of the problem/report:
I am currently using raw sockets with ETH_P_ALL, in order to capture all
the packets coming from my ethernet NIC, together with hardware
timestamping (set by using the SO_TIMESTAMPING socket option).

In particular, I set up everything as in the code reported in the example
program (point [7. ]).
I create a socket with:
socket(AF_PACKET,SOCK_RAW,htons(ETH_P_ALL))

Then, I enable hardware timestamps by calling the proper ioctl:
ioctl(sock,SIOCSHWTSTAMP,&hwtstamp)

and by setting:
flags=SOF_TIMESTAMPING_RX_HARDWARE | SOF_TIMESTAMPING_TX_HARDWARE |
SOF_TIMESTAMPING_RAW_HARDWARE;
setsockopt(sock,SOL_SOCKET,SO_TIMESTAMPING,&flags,sizeof(flags))

Everything is performed according to the timestaping documentation:
https://www.kernel.org/doc/Documentation/networking/timestamping.txt

Hardware timestamps should be reported as ancillary data. If ETH_P_ALL is
set, no timestamps are reported and mhdr.msg_controllen (from struct msghdr
mhdr) is always 0, after each recvmsg.
Sometimes, only the first received packet timestamp is reported, but all
the others are not.
If other protocols are set, such as ETH_P_IP, timestamps are correctly
reported:
socket(AF_PACKET,SOCK_RAW,htons(ETH_P_IP))

Hardware: system 1: Intel Corporation Ethernet Connection (4) I219-V (rev
21) - e1000e
system 2: Intel Corporation I210 Gigabit Network Connection (rev 03)

[3.] Keywords (i.e., modules, networking, kernel):
networking, timestamps, timestamping, sockets, AF_PACKET, ETH_P_ALL,
ETH_P_IP, CSMG, ancillary data, SOF_TIMESTAMPING_RAW_HARDWARE, Intel NIC

[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
system 1: Linux version 5.0.0-16-generic (buildd at lgw01-amd64-060) (gcc
version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #17-Ubuntu SMP Wed May 15 10:52:21
UTC 2019

system 2: Linux version 4.14.95 (francesco at francesco-pcengines-dev) (gcc
version 7.3.0 (OpenWrt GCC 7.3.0 r7676-cddd7b4c77)) #0 SMP Wed Jan 30
12:21:02 2019

[5.] Most recent kernel version which did not have the bug:
None

[7.] A small shell script or example program which triggers the
     problem (if possible):

     Example C program:

#include <arpa/inet.h>
#include <linux/net_tstamp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/sockios.h>
#include <unistd.h>
#include <linux/if.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <linux/ip.h>
#include <linux/errqueue.h>

int main(int argc, char* argv[]) {
   struct ifreq ifindexreq;
   int pkt_counter=0;
   int flags;
   int sock;
   int ifindex;
   struct sockaddr_ll si_server;

   struct msghdr mhdr;
   struct iovec iov;
   struct cmsghdr *cmsg = NULL;

   struct ifreq hwtstamp;
   struct hwtstamp_config hwconfig;

   unsigned char buffer[1514];
   char ctrlBuffer[CMSG_SPACE(sizeof(struct scm_timestamping))];
   struct scm_timestamping hw_ts;

   struct iphdr *iphdr_ptr;
   struct in_addr saddr_ip;

   int rx_bytes;

   fprintf(stdout,"Program started.\n");

   if(argc!=2) {
       fprintf(stderr,"Error. You should specify the interface name.\n");
       exit(1);
   }

   // Create socket
   if ((sock = socket(AF_PACKET,SOCK_RAW,htons(ETH_P_ALL))) < 0) {
       perror("RAW socket()");
       exit(EXIT_FAILURE);
   }

   // Get interface index
   strncpy(ifindexreq.ifr_name,argv[1],IFNAMSIZ);
   if(ioctl(sock,SIOCGIFINDEX,&ifindexreq)!=-1) {
       ifindex=ifindexreq.ifr_ifindex;
   } else {
  perror("SIOCGIFINDEX ioctl()");
      close(sock);
      exit(EXIT_FAILURE);
   }

   memset(&si_server, 0, sizeof(si_server));
   si_server.sll_ifindex=ifindex;
   si_server.sll_family=AF_PACKET;

// bind() to interface
  if(bind(sock,(struct sockaddr *) &si_server,sizeof(si_server))<0) {
perror("bind()");
       close(sock);
       exit(EXIT_FAILURE);
}

   // Set hardware timestamping
   memset(&hwtstamp,0,sizeof(hwtstamp));
   memset(&hwconfig,0,sizeof(hwconfig));

   // Set ifr_name and ifr_data
   strncpy(hwtstamp.ifr_name,argv[1],sizeof(hwtstamp.ifr_name));
   hwtstamp.ifr_data=(void *)&hwconfig;

   hwconfig.tx_type=HWTSTAMP_TX_ON;
   hwconfig.rx_filter=HWTSTAMP_FILTER_ALL;

   // Issue request to the driver
   if (ioctl(sock,SIOCSHWTSTAMP,&hwtstamp)<0) {
       perror("ioctl(SIOCSHWTSTAMP)");
       close(sock);
       exit(EXIT_FAILURE);
   }

   flags=SOF_TIMESTAMPING_RX_HARDWARE | SOF_TIMESTAMPING_TX_HARDWARE |
SOF_TIMESTAMPING_RAW_HARDWARE;

   if(setsockopt(sock,SOL_SOCKET,SO_TIMESTAMPING,&flags,sizeof(flags))<0) {
               perror("setsockopt(SO_TIMESTAMPING)");
       close(sock);
       exit(EXIT_FAILURE);
   }

   memset(&mhdr,0,sizeof(mhdr));

   // iovec buffers (scatter/gather arrays)
   iov.iov_base=buffer;
   iov.iov_len=sizeof(buffer);

   // Socket address structure
   mhdr.msg_name=NULL;
   mhdr.msg_namelen=0;

   // Ancillary data (control message)
   mhdr.msg_control=ctrlBuffer;
   mhdr.msg_controllen=sizeof(ctrlBuffer);

   // iovec arrays
   mhdr.msg_iov=&iov;
   mhdr.msg_iovlen=1;

   fprintf(stdout,"(Before while loop) CMSG_FIRSTHDR(&mhdr)=%p
(len=%zd)\n",CMSG_FIRSTHDR(&mhdr),mhdr.msg_controllen);
   // Receive 10 packets, then stop
   while(pkt_counter<10) {
       rx_bytes=recvmsg(sock,&mhdr,0);

       // Find IP address from packet (just for printing)
       iphdr_ptr=(struct iphdr *) (buffer+sizeof(struct ether_header));
       saddr_ip.s_addr=iphdr_ptr->saddr;
       fprintf(stdout,"Received a packet from %s
(len=%d).\n",inet_ntoa(saddr_ip),rx_bytes);

       fprintf(stdout,"(Inside while loop - %d) CMSG_FIRSTHDR(&mhdr)=%p
(len=%zd)\n",pkt_counter,CMSG_FIRSTHDR(&mhdr),mhdr.msg_controllen);
       for(cmsg=CMSG_FIRSTHDR(&mhdr);cmsg!=NULL;cmsg=CMSG_NXTHDR(&mhdr,
cmsg)) {
           if(cmsg->cmsg_level==SOL_SOCKET &&
cmsg->cmsg_type==SO_TIMESTAMPING) {
               hw_ts=*((struct scm_timestamping *)CMSG_DATA(cmsg));
               fprintf(stdout,"RX timestamp: sec = %lu , nsec =
%lu\n",hw_ts.ts[2].tv_sec,hw_ts.ts[2].tv_nsec);
           }
       }
       pkt_counter++;
   }

   close(sock);

   return 0;
}

Example output when htons(ETH_P_ALL) is set:
$ sudo ./testrx enp0s31f6
Program started.
(Before while loop) CMSG_FIRSTHDR(&mhdr)=0x7fffd384f5c0 (len=64)
Received a packet from 162.125.18.133 (len=323).
(Inside while loop - 0) CMSG_FIRSTHDR(&mhdr)=0x7fffd384f5c0 (len=64)
RX timestamp: sec = 1564132845 , nsec = 678740274
Received a packet from 192.168.1.210 (len=609).
(Inside while loop - 1) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 162.125.18.133 (len=66).
(Inside while loop - 2) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 192.168.1.210 (len=650).
(Inside while loop - 3) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 162.125.18.133 (len=66).
(Inside while loop - 4) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 192.168.1.250 (len=146).
(Inside while loop - 5) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 192.168.1.210 (len=66).
(Inside while loop - 6) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 192.168.1.210 (len=114).
(Inside while loop - 7) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 192.168.1.250 (len=66).
(Inside while loop - 8) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)
Received a packet from 192.168.1.210 (len=90).
(Inside while loop - 9) CMSG_FIRSTHDR(&mhdr)=(nil) (len=0)

"(Inside while loop - 0)" is sometimes reported, some other not reported,
as for all the other received packets.

Example output when htons(ETH_P_IP) is set:
$ sudo ./testrx enp0s31f6
Program started.
(Before while loop) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
Received a packet from 192.168.1.250 (len=98).
(Inside while loop - 0) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133136 , nsec = 669293274
Received a packet from 192.168.1.250 (len=194).
(Inside while loop - 1) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133136 , nsec = 669788649
Received a packet from 192.168.1.250 (len=98).
(Inside while loop - 2) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133137 , nsec = 709189274
Received a packet from 192.168.1.250 (len=194).
(Inside while loop - 3) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133137 , nsec = 709855774
Received a packet from 192.168.1.250 (len=98).
(Inside while loop - 4) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133138 , nsec = 759102399
Received a packet from 192.168.1.250 (len=194).
(Inside while loop - 5) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133138 , nsec = 759642149
Received a packet from 192.168.1.250 (len=98).
(Inside while loop - 6) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133139 , nsec = 789017024
Received a packet from 192.168.1.250 (len=194).
(Inside while loop - 7) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133139 , nsec = 789737149
Received a packet from 192.168.1.250 (len=98).
(Inside while loop - 8) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133140 , nsec = 828939899
Received a packet from 192.168.1.250 (len=194).
(Inside while loop - 9) CMSG_FIRSTHDR(&mhdr)=0x7ffd65075280 (len=64)
RX timestamp: sec = 1564133140 , nsec = 829930149


[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
-------------------------------------------------------------------------------
system 1:
Linux francesco-HP-EliteBook-830-G5 5.0.0-16-generic #17-Ubuntu SMP Wed May
15 10:52:21 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

GNU Make             4.2.1
Binutils             2.32
Util-linux           2.33.1
Mount               2.33.1
Module-init-tools   25
E2fsprogs           1.44.6
Pcmciautils         018
PPP                 2.4.7
Linux C Library     2.29
Dynamic linker (ldd) 2.29
Linux C++ Library   6.0.26
Procps               3.3.15
Net-tools           2.10
Kbd                 2.0.4
Console-tools       2.0.4
Sh-utils             8.30
Udev                 240
Wireless-tools       30
Modules Loaded       ac97_bus acpi_pad acpi_thermal_rel aesni_intel
aes_x86_64 ahci arc4 aufs autofs4 binfmt_misc bluetooth bnep btbcm btintel
btrtl btusb cfg80211 coretemp crc32_pclmul crct10dif_pclmul cryptd
crypto_simd drm drm_kms_helper e1000e ecdh_generic fb_sys_fops
ghash_clmulni_intel glue_helper hid hid_generic hid_multitouch hp_wireless
hp_wmi i2c_algo_bit i2c_hid i2c_i801 i915 idma64 input_leds int3400_thermal
int3403_thermal int340x_thermal_zone intel_cstate intel_lpss intel_lpss_pci
intel_pch_thermal intel_powerclamp intel_rapl intel_rapl_perf
intel_soc_dts_iosf intel_wmi_thunderbolt intel_xhci_usb_role_switch
ip_tables irqbypass iwlmvm iwlwifi joydev kvm kvmgt kvm_intel ledtrig_audio
libahci lp mac80211 mac_hid mdev media mei mei_me nfnetlink nfnetlink_log
nfnetlink_queue nls_iso8859_1 overlay parport parport_pc pinctrl_intel
pinctrl_sunrisepoint ppdev processor_thermal_device psmouse rfcomm roles
sch_fq_codel serio_raw snd snd_compress snd_hda_codec
snd_hda_codec_conexant snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_core snd_hda_ext_core snd_hda_intel snd_hwdep snd_pcm
snd_pcm_dmaengine snd_rawmidi snd_seq snd_seq_device snd_seq_midi
snd_seq_midi_event snd_soc_acpi snd_soc_acpi_intel_match snd_soc_core
snd_soc_hdac_hda snd_soc_skl snd_soc_skl_ipc snd_soc_sst_dsp
snd_soc_sst_ipc snd_timer soundcore sparse_keymap syscopyarea sysfillrect
sysimgblt thunderbolt typec typec_ucsi ucsi_acpi usbhid uvcvideo vfio
vfio_iommu_type1 vfio_mdev video videobuf2_common videobuf2_memops
videobuf2_v4l2 videobuf2_vmalloc videodev virt_dma wmi wmi_bmof
x86_pkg_temp_thermal x_tables

-------------------------------------------------------------------------------
system 2:
Linux OpenWrt 4.14.95 #0 SMP Wed Jan 30 12:21:02 2019 x86_64 GNU/Linux

GNU C               5.4.0
GNU Make             4.2.1
Binutils             2.27
Util-linux           512
Mount               512
PPP                 2.4.7
Dynamic linker (ldd) 86
Linux C++ Library   1.28.4
Procps               1.28.4
Modules Loaded       akcipher asn1_decoder ath ath10k_core ath10k_pci ath5k
ath9k ath9k_common ath9k_htc ath9k_hw authenc button_hotplug ccp ccp_crypto
cfg80211 compat crc_ccitt e1000 e1000e ehci_platform gpio_button_hotplug
gpio_nct5104d i2c_algo_bit i2c_dev igb ip6_tables ip6t_REJECT
ip6table_filter ip6table_mangle ip_tables ipt_MASQUERADE ipt_REJECT
iptable_filter iptable_mangle iptable_nat leds_apu2 lib80211
lib80211_crypt_ccmp lib80211_crypt_tkip lib80211_crypt_wep mac80211 mii mpi
nf_conntrack nf_conntrack_ipv4 nf_conntrack_ipv6 nf_conntrack_rtcache
nf_defrag_ipv4 nf_defrag_ipv6 nf_dup_ipv4 nf_dup_ipv6 nf_flow_table
nf_flow_table_hw nf_log_common nf_log_ipv4 nf_log_ipv6 nf_nat nf_nat_ipv4
nf_nat_masquerade_ipv4 nf_nat_redirect nf_reject_ipv4 nf_reject_ipv6
ppp_async ppp_generic pppoe pppox pps_core ptp r8169 rsa_generic
sha1_generic sha1_ssse3 sha256_generic sha256_ssse3 slhc snd snd_compress
snd_hwdep snd_mixer_oss snd_pcm snd_pcm_oss snd_pcsp snd_rawmidi
snd_seq_device snd_timer soundcore sp5100_tco x_tables xhci_plat_hcd
xt_FLOWOFFLOAD xt_LOG xt_REDIRECT xt_TCPMSS xt_TEE xt_comment xt_conntrack
xt_limit xt_mac xt_mark xt_multiport xt_nat xt_state xt_tcpudp xt_time

[8.2.] Processor information (from /proc/cpuinfo):
-------------------------------------------------------------------------------
system 1:
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping : 9
microcode : 0xb4
cpu MHz : 800.017
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt
xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp md_clear flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds
bogomips : 5424.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping : 9
microcode : 0xb4
cpu MHz : 800.007
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt
xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp md_clear flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds
bogomips : 5424.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping : 9
microcode : 0xb4
cpu MHz : 800.016
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt
xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp md_clear flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds
bogomips : 5424.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 142
model name : Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
stepping : 9
microcode : 0xb4
cpu MHz : 800.008
cache size : 3072 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt
xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp md_clear flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds
bogomips : 5424.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

-------------------------------------------------------------------------------
system 2:
processor : 0
vendor_id : AuthenticAMD
cpu family : 22
model : 48
model name : AMD GX-412TC SOC
stepping : 1
microcode : 0x7030105
cpu MHz : 598.589
cache size : 2048 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc cpuid
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt topoext perfctr_nb
bpext ptsc perfctr_llc cpb hw_pstate ssbd vmmcall bmi1 xsaveopt arat npt
lbrv svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2
spec_store_bypass
bogomips : 1996.33
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb acc_power [13]

processor : 1
vendor_id : AuthenticAMD
cpu family : 22
model : 48
model name : AMD GX-412TC SOC
stepping : 1
microcode : 0x7030105
cpu MHz : 598.592
cache size : 2048 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 4
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc cpuid
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt topoext perfctr_nb
bpext ptsc perfctr_llc cpb hw_pstate ssbd vmmcall bmi1 xsaveopt arat npt
lbrv svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2
spec_store_bypass
bogomips : 1996.33
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb acc_power [13]

processor : 2
vendor_id : AuthenticAMD
cpu family : 22
model : 48
model name : AMD GX-412TC SOC
stepping : 1
microcode : 0x7030105
cpu MHz : 598.672
cache size : 2048 KB
physical id : 0
siblings : 4
core id : 2
cpu cores : 4
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc cpuid
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt topoext perfctr_nb
bpext ptsc perfctr_llc cpb hw_pstate ssbd vmmcall bmi1 xsaveopt arat npt
lbrv svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2
spec_store_bypass
bogomips : 1996.33
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb acc_power [13]

processor : 3
vendor_id : AuthenticAMD
cpu family : 22
model : 48
model name : AMD GX-412TC SOC
stepping : 1
microcode : 0x7030105
cpu MHz : 598.778
cache size : 2048 KB
physical id : 0
siblings : 4
core id : 3
cpu cores : 4
apicid : 3
initial apicid : 3
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc cpuid
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 movbe
popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt topoext perfctr_nb
bpext ptsc perfctr_llc cpb hw_pstate ssbd vmmcall bmi1 xsaveopt arat npt
lbrv svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter
pfthreshold overflow_recov
bugs : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2
spec_store_bypass
bogomips : 1996.33
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb acc_power [13]

[8.3.] Module information (from /proc/modules):
system 1:
e1000e 245760 0 - Live 0x0000000000000000

system 2:
e1000e 155648 0 - Live 0xffffffffa0198000
igb 139264 0 - Live 0xffffffffa013f000
i2c_algo_bit 16384 1 igb, Live 0xffffffffa0138000
ptp 20480 2 e1000e,igb, Live 0xffffffffa000f000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
-------------------------------------------------------------------------------
system 1 (/proc/ioports):
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
  0000-0000 : pnp 00:08
  0000-0000 : iTCO_wdt
  0000-0000 : pnp 00:03
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : pnp 00:03
  0000-0000 : pnp 00:03
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : ACPI CPU throttle
    0000-0000 : iTCO_wdt
    0000-0000 : ACPI PM2_CNT_BLK
    0000-0000 : pnp 00:05
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : pnp 00:02
  0000-0000 : 0000:00:02.0
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : 0000:00:17.0
    0000-0000 : ahci
  0000-0000 : PCI Bus 0000:02
  0000-0000 : 0000:00:1f.4
    0000-0000 : i801_smbus
  0000-0000 : pnp 00:03
    0000-0000 : pnp 00:03
      0000-0000 : pnp 00:03

system 1 (/proc/iomem):
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : PCI Bus 0000:00
    00000000-00000000 : System ROM
00000000-00000000 : System RAM
  00000000-00000000 : Kernel code
  00000000-00000000 : Kernel data
  00000000-00000000 : Kernel bss
00000000-00000000 : Reserved
  00000000-00000000 : pnp 00:00
00000000-00000000 : System RAM
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Unknown E820 type
00000000-00000000 : Reserved
00000000-00000000 : ACPI Non-volatile Storage
  00000000-00000000 : USBC000:00
00000000-00000000 : ACPI Tables
00000000-00000000 : System RAM
00000000-00000000 : Reserved
  00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : pnp 00:0b
  00000000-00000000 : PCI Bus 0000:02
  00000000-00000000 : PCI Bus 0000:01
    00000000-00000000 : 0000:01:00.0
      00000000-00000000 : iwlwifi
  00000000-00000000 : 0000:00:1f.6
    00000000-00000000 : e1000e
  00000000-00000000 : 0000:00:14.0
    00000000-00000000 : xhci-hcd
      00000000-00000000 : intel_xhci_usb_sw
  00000000-00000000 : 0000:00:1f.2
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
  00000000-00000000 : 0000:00:17.0
    00000000-00000000 : ahci
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-7f]
  00000000-00000000 : Reserved
    00000000-00000000 : pnp 00:0b
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : pnp 00:01
  00000000-00000000 : INT344B:00
    00000000-00000000 : INT344B:00
  00000000-00000000 : pnp 00:01
  00000000-00000000 : INT344B:00
    00000000-00000000 : INT344B:00
  00000000-00000000 : INT344B:00
    00000000-00000000 : INT344B:00
  00000000-00000000 : pnp 00:01
    00000000-00000000 : iTCO_wdt
  00000000-00000000 : Reserved
  00000000-00000000 : pnp 00:0a
  00000000-00000000 : pnp 00:09
  00000000-00000000 : pnp 00:09
  00000000-00000000 : pnp 00:01
00000000-00000000 : IOAPIC 0
00000000-00000000 : HPET 0
  00000000-00000000 : PNP0103:00
00000000-00000000 : pnp 00:0b
00000000-00000000 : pnp 00:0b
00000000-00000000 : pnp 00:0b
00000000-00000000 : pnp 00:0b
00000000-00000000 : IFX0763:00
  00000000-00000000 : IFX0763:00
00000000-00000000 : pnp 00:0b
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : pnp 00:08
00000000-00000000 : pnp 00:0b
  00000000-00000000 : Local APIC
00000000-00000000 : INT0800:00
  00000000-00000000 : pnp 00:0b
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : PCI Bus 0000:00
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : PCI Bus 0000:02
  00000000-00000000 : 0000:00:02.0
  00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:04.0
  00000000-00000000 : 0000:00:1f.3
    00000000-00000000 : ICH HD audio
  00000000-00000000 : 0000:00:1f.4
  00000000-00000000 : 0000:00:16.0
    00000000-00000000 : mei_me
  00000000-00000000 : 0000:00:15.1
    00000000-00000000 : lpss_dev
      00000000-00000000 : lpss_dev
    00000000-00000000 : lpss_priv
    00000000-00000000 : idma64.1
      00000000-00000000 : idma64.1
  00000000-00000000 : 0000:00:15.0
    00000000-00000000 : lpss_dev
      00000000-00000000 : lpss_dev
    00000000-00000000 : lpss_priv
    00000000-00000000 : idma64.0
      00000000-00000000 : idma64.0
  00000000-00000000 : 0000:00:14.2
    00000000-00000000 : Intel PCH thermal driver

-------------------------------------------------------------------------------
system 2 (/proc/ioports):
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0064-0064 : keyboard
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
  02f8-02ff : serial
  03c0-03df : vga+
  03f8-03ff : serial
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0810-0817 : ACPI GPE0_BLK
  0818-081b : ACPI PM_TMR
  0cd6-0cd7 : SB800 TCO
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:02
    1000-101f : 0000:02:00.0
  2000-2fff : PCI Bus 0000:03
    2000-201f : 0000:03:00.0
  3000-3fff : PCI Bus 0000:04
    3000-301f : 0000:04:00.0
  4000-400f : 0000:00:11.0
    4000-400f : ahci
  4010-4017 : 0000:00:11.0
    4010-4017 : ahci
  4018-401f : 0000:00:11.0
    4018-401f : ahci
  4020-4023 : 0000:00:11.0
    4020-4023 : ahci
  4024-4027 : 0000:00:11.0
    4024-4027 : ahci

system 2 (/proc/iomem):
00000000-00000fff : Reserved
00001000-0009f7ff : System RAM
0009f800-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
  000c0000-000c7fff : Video ROM
000f0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-dffadfff : System RAM
  01000000-018021d0 : Kernel code
  018021d1-01c805bf : Kernel data
  01d9b000-01df8fff : Kernel bss
dffae000-dfffffff : Reserved
e0000000-ffffffff : PCI Bus 0000:00
  f8000000-fbffffff : Reserved
  fe200000-fe4fffff : PCI Bus 0000:01
    fe200000-fe3fffff : 0000:01:00.0
      fe200000-fe3fffff : ath
    fe400000-fe40ffff : 0000:01:00.0
  fe500000-fe5fffff : PCI Bus 0000:02
    fe500000-fe51ffff : 0000:02:00.0
      fe500000-fe51ffff : igb
    fe520000-fe523fff : 0000:02:00.0
      fe520000-fe523fff : igb
  fe600000-fe6fffff : PCI Bus 0000:03
    fe600000-fe61ffff : 0000:03:00.0
      fe600000-fe61ffff : igb
    fe620000-fe623fff : 0000:03:00.0
      fe620000-fe623fff : igb
  fe700000-fe7fffff : PCI Bus 0000:04
    fe700000-fe71ffff : 0000:04:00.0
      fe700000-fe71ffff : igb
    fe720000-fe723fff : 0000:04:00.0
      fe720000-fe723fff : igb
  fe800000-fe8fffff : 0000:00:08.0
    fe800000-fe8fffff : ccp
  fe900000-fe9fffff : 0000:00:08.0
    fe900000-fe9fffff : ccp
  fea00000-fea1ffff : 0000:00:08.0
    fea00000-fea1ffff : ccp
  fea20000-fea21fff : 0000:00:08.0
    fea20000-fea21fff : ccp
  fea22000-fea23fff : 0000:00:10.0
    fea22000-fea23fff : xhci-hcd
  fea24000-fea24fff : 0000:00:08.0
    fea24000-fea24fff : ccp
  fea25000-fea253ff : 0000:00:11.0
    fea25000-fea253ff : ahci
  fea25400-fea254ff : 0000:00:13.0
    fea25400-fea254ff : ehci_hcd
  fea25500-fea255ff : 0000:00:14.7
    fea25500-fea255ff : mmc0
  feb00000-feb00007 : SB800 TCO
  fec00000-fec003ff : IOAPIC 0
  fec10002-fec11001 : pnp 00:00
  fec20000-fec203ff : IOAPIC 1
  fed00000-fed003ff : HPET 0
  fed81500-fed817ff : leds-apu2
  fee00000-fee00fff : Local APIC
100000000-11effffff : System RAM
11f000000-11fffffff : RAM buffer

[8.5.] PCI information ('lspci -vvv' as root)
system 1:
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4)
I219-V (rev 21)
Subsystem: Hewlett-Packard Company Ethernet Connection (4) I219-V
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 123
Region 0: Memory@b6200000 (32-bit, non-prefetchable) [size=128K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00278  Data: 0000
Capabilities: [e0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: e1000e
Kernel modules: e1000e

system 2:
02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
Connection (rev 03)
Subsystem: Intel Corporation Device 0000
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 35
Region 0: Memory at fe500000 (32-bit, non-prefetchable) [size=128K]
Region 2: I/O ports at 1000 [size=32]
Region 3: Memory@fe520000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
Address: 0000000000000000  Data: 0000
Masking: 00000000  Pending: 00000000
Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
Vector table: BAR=3 offset=00000000
PBA: BAR=3 offset=00002000
Capabilities: [a0] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<2us, L1 <16us
ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt-
ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
AtomicOpsCtl: ReqEn-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+
ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [140 v1] Device Serial Number 00-0d-b9-ff-ff-50-8a-7c
Capabilities: [1a0 v1] Transaction Processing Hints
Device specific mode supported
Steering table in TPH capability structure
Kernel driver in use: igb

[8.6.] SCSI information (from /proc/scsi/scsi)
system 1:
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WDS500G2B0B  Rev: 90WD
  Type:   Direct-Access                    ANSI  SCSI revision: 05

system 2:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SATA SSD         Rev: 01.2
  Type:   Direct-Access                    ANSI  SCSI revision: 05


[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

  ethtool -T <ethernet interface> output

system 1:
$ ethtool -T enp0s31f6
Time stamping parameters for enp0s31f6:
Capabilities:
hardware-transmit     (SOF_TIMESTAMPING_TX_HARDWARE)
software-transmit     (SOF_TIMESTAMPING_TX_SOFTWARE)
hardware-receive      (SOF_TIMESTAMPING_RX_HARDWARE)
software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
hardware-raw-clock    (SOF_TIMESTAMPING_RAW_HARDWARE)
PTP Hardware Clock: 0
Hardware Transmit Timestamp Modes:
off                   (HWTSTAMP_TX_OFF)
on                    (HWTSTAMP_TX_ON)
Hardware Receive Filter Modes:
none                  (HWTSTAMP_FILTER_NONE)
all                   (HWTSTAMP_FILTER_ALL)
ptpv1-l4-sync         (HWTSTAMP_FILTER_PTP_V1_L4_SYNC)
ptpv1-l4-delay-req    (HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ)
ptpv2-l4-sync         (HWTSTAMP_FILTER_PTP_V2_L4_SYNC)
ptpv2-l4-delay-req    (HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ)
ptpv2-l2-sync         (HWTSTAMP_FILTER_PTP_V2_L2_SYNC)
ptpv2-l2-delay-req    (HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ)
ptpv2-event           (HWTSTAMP_FILTER_PTP_V2_EVENT)
ptpv2-sync            (HWTSTAMP_FILTER_PTP_V2_SYNC)
ptpv2-delay-req       (HWTSTAMP_FILTER_PTP_V2_DELAY_REQ)

system 2:
# ethtool -T eth2
Time stamping parameters for eth2:
Capabilities:
hardware-transmit     (SOF_TIMESTAMPING_TX_HARDWARE)
software-transmit     (SOF_TIMESTAMPING_TX_SOFTWARE)
hardware-receive      (SOF_TIMESTAMPING_RX_HARDWARE)
software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
hardware-raw-clock    (SOF_TIMESTAMPING_RAW_HARDWARE)
PTP Hardware Clock: 2
Hardware Transmit Timestamp Modes:
off                   (HWTSTAMP_TX_OFF)
on                    (HWTSTAMP_TX_ON)
Hardware Receive Filter Modes:
none                  (HWTSTAMP_FILTER_NONE)
all                   (HWTSTAMP_FILTER_ALL)



Best regards,
Francesco
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190726/a5f4122b/attachment-0001.html>
