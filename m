From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 2 Sep 2021 13:28:36 +0300
Subject: [Intel-wired-lan] Slow e1000e Network Interface with different
 kernel
In-Reply-To: <0c8eb89c-4a55-d977-312f-6856ea5b59ba@neusta.de>
References: <0c8eb89c-4a55-d977-312f-6856ea5b59ba@neusta.de>
Message-ID: <f3cc2e12-d717-4de1-160c-062b4de988e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/2/2021 13:01, Marco Witte wrote:
> Scenario: Plugin into network, establishes link and IP is assigned.
> scp from another machine in the same subnet gives approx. 1kb/sec.
> Cross check with an usb 3 dock with integrated network adapter. Full speed.
> 
> Kai Heng-Feng build a patch for tgp https://lkml.org/lkml/2021/7/12/2927
> His deb kernel packages with that patch based on 5.10.x kernel ran full 
> throttle on this machine.
> However this was the only successfull attempt to get full speed.
> 
> The Kernel Mainline 5.13. contains visual similar patches, but they 
> still have the slow down on the same machine.
> Some people suspect pcie changes at that point.
> 
> Some curious fact I found out while testing: I booted up a manjaro 
> (current) usb stick and had full speed on the e1000e. Then I installed 
> manjaro from that stick to the harddrive. Booted that and it didn't 
> perform well.
> 
> As this is my first rodeo on this mailinglist, I need to reference some 
> information:
> 
> Referencing: https://bugzilla.kernel.org/show_bug.cgi?id=213377
> Here is the launchpad: 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1927925
> e1000e Sourceforge bugreport(s): https://sourceforge.net/p/e1000/bugs/681/
> This is still an issue with all current mainline kernels. Last test was 
> 5.14 RC7
> 
> I can provide any output you need.
> 
Marco,
Run echo on > /sys/bus/pci/devices/0000\:00\:16.0/power/control command 
on your machine.
Please, let us know the result.

> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
Sasha
