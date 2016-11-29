From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 29 Nov 2016 10:04:44 +0200
Subject: [Intel-wired-lan] Fwd: FW: [PATCH] e1000e: x86: e1000 driver trying
 to free already-free irq.
In-Reply-To: <630A6B92B7EDEB45A87E20D3D286660153E3F990@hasmsx109.ger.corp.intel.com>
References: <630A6B92B7EDEB45A87E20D3D286660153E3F990@hasmsx109.ger.corp.intel.com>
Message-ID: <14e1aa00-13b4-e02d-71ca-1c85184996a2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-------- Forwarded Message --------
Subject: FW: [PATCH] e1000e: x86: e1000 driver trying to free
already-free irq.
Date: Tue, 29 Nov 2016 09:54:40 +0200
From: Neftin, Sasha <sasha.neftin@intel.com>
To: Neftin, Sasha <sasha.neftin@intel.com>



Skype Me???! -----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
On Behalf Of David Singleton -X (davsingl - MONTA VISTA SOFTWARE INC at
Cisco)
Sent: Thursday, November 24, 2016 5:18 AM
To: Brown, Aaron F <aaron.f.brown@intel.com>
Cc: David Singleton -X (davsingl - MONTA VISTA SOFTWARE INC at Cisco)
<davsingl@cisco.com>; intel-wired-lan at lists.osuosl.org; Khalid Mughal
(khalidm) <khalidm@cisco.com>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: x86: e1000 driver trying
to free already-free irq.

Any further status on getting this fix into kernel.org?


> On Oct 27, 2016, at 7:50 PM, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
> 
>> From: netdev-owner at vger.kernel.org [mailto:netdev- 
>> owner at vger.kernel.org] On Behalf Of David Singleton
>> Sent: Monday, October 17, 2016 9:51 AM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: khalidm <khalidm@cisco.com>; intel-wired-lan at lists.osuosl.org; 
>> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
>> Subject: [PATCH] e1000e: x86: e1000 driver trying to free already-free irq.
>> 
>> From: khalidm <khalidm@cisco.com>
>> 
>> During systemd reboot sequence network driver interface is shutdown 
>> by e1000_close. The PCI driver interface is shut by e1000_shutdown.
>> The e1000_shutdown checks for netif_running status, if still up it 
>> brings down driver. But it disables msi outside of this if statement, 
>> regardless of netif status. All this is OK when e1000_close happens 
>> after shutdown. However, by default, everything in systemd is done in 
>> parallel. This creates a conditions where e1000_shutdown is called 
>> after e1000_close, therefore hitting BUG_ON assert in free_msi_irqs.
>> 
>> Cc-Id: xe-kernel at external.cisco.com
>> Signed-off-by: khalidm <khalidm@cisco.com>
>> Signed-off-by: David Singleton <davsingl@cisco.com>
>> ---
>> drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Hello David,
I would like recommend do not change kernel code in this moment. This is
very sensitive for a driver state machine and we afraid from opening lot
of issues. As I know hit on BUG_ON happen on very old NIC. Our more new
NIC do not experienced such problem.
What is the NIC you use? Do you experience problem with another ours
NIC, igb for example?
Sasha

