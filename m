From: David Singleton -X (davsingl - MONTA VISTA SOFTWARE INC@Cisco) <davsingl@cisco.com>
Date: Thu, 24 Nov 2016 03:18:20 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: x86: e1000 driver trying to
 free already-free irq.
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81FBD577@ORSMSX101.amr.corp.intel.com>
References: <20161017165108.29718-5-davsingl@cisco.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81FBD577@ORSMSX101.amr.corp.intel.com>
Message-ID: <A8ED267C-17E1-4DDF-BC3D-04AF7DE4BFFB@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

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
>> after shutdown. However, by default, everything in systemd is done
>> in parallel. This creates a conditions where e1000_shutdown is called
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

