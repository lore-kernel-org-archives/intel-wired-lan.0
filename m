From: Diego Rodriguez Gonzalez <gran.diego@gmail.com>
Date: Wed, 25 May 2016 08:11:10 +0200
Subject: [Intel-wired-lan] [PROBLEM] e1000e driver failed with error -3
In-Reply-To: <mailman.9684.1463574872.23286.intel-wired-lan@lists.osuosl.org>
References: <mailman.9684.1463574872.23286.intel-wired-lan@lists.osuosl.org>
Message-ID: <574541FE.9070209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

El 18/05/16 a las 14:34, intel-wired-lan-request at lists.osuosl.org escribi?:
> Date: Wed, 18 May 2016 14:34:31 +0200
> From: Diego Rodriguez Gonzalez <gran.diego@gmail.com>
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PROBLEM] e1000e driver failed with error
> 	-3
> Message-ID: <573C6157.3040007@gmail.com>
> Content-Type: text/plain; charset="utf-8"; Format="flowed"
>
>
> [1.]
> On cold boot, e1000e fails with error -3. On reboot, works fine
>
> [2.]
> Failure to load e1000e on cold boot render network card unusable. After
> reboot, module loads with no error and network card works properly.
>
> [3.]
> e1000e
>
> [4.]
> Linux version 4.6.0-040600-generic (kernel at gomeisa) (gcc version 5.3.1
> 20160509 (Ubuntu 5.3.1-19ubuntu1) ) #201605151930 SMP Sun May 15
> 23:32:59 UTC 2016
[...]

> More info at
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1576953
>
> Best regards,
> Diego
>

I've downloaded kernel 4.6.0 from kernel.org, patched using

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1583750/+attachment/4666376/+files/0001-e1000e-added-more-error-output-during-probe.patch

To increase verbosity of e1000e, and after a cold boot, I got this:

~$ dmesg | grep e1000e
[ 1.273616] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[ 1.273619] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[ 1.273784] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[ 2.270530] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): Failed to 
acquire the semaphore, FW or HW has it: FWSM=0x60000040 EXTCNF_
CTRL=0x002800c9)
[ 2.272412] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): Failed to 
initialize PHY flow (-3)
[ 2.273634] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): 
e1000_init_phy_params_pchlan: e1000_init_phy_workarounds_pchlan returned -3
[ 2.275351] e1000e 0000:00:19.0: e1000_init_phy_params-* failed with -3 
(mac.type 11)
[ 2.276444] e1000e 0000:00:19.0: ei->get_variants failed with -3
[ 2.286596] e1000e: probe of 0000:00:19.0 failed with error -3
On warm reboot, log shows:

~$ dmesg | grep e1000e
[ 1.308156] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[ 1.308158] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[ 1.308326] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[ 1.481950] e1000e 0000:00:19.0 eth0: registered PHC clock
[ 1.481954] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 
80:fa:5b:13:9f:02
[ 1.481956] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[ 1.482015] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
[ 32.693226] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow 
Control: Rx/Tx
[ 32.693232] e1000e 0000:00:19.0 eth0: 10/100 speed: disabling TSO

Best regards,
Diego

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3589 bytes
Desc: Firma criptogr??fica S/MIME
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160525/7c02f13c/attachment-0001.p7s>
