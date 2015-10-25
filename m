From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 24 Oct 2015 23:03:04 -0700
Subject: [Intel-wired-lan] [RFC Patch 05/12] IXGBE: Add new sysfs
	interface of "notify_vf"
In-Reply-To: <562BA729.10903@intel.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-6-git-send-email-tianyu.lan@intel.com>
 <5627FB20.3020003@gmail.com> <562BA729.10903@intel.com>
Message-ID: <562C7098.4030406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/24/2015 08:43 AM, Lan, Tianyu wrote:
>
> On 10/22/2015 4:52 AM, Alexander Duyck wrote:
>> Also have you even considered the MSI-X configuration on the VF?  I
>> haven't seen anything anywhere that would have migrated the VF's MSI-X
>> configuration from BAR 3 on one system to the new system.
>
> MSI-X migration is done by Hypervisor(Qemu).
> Following link is my Qemu patch to do that.
> http://marc.info/?l=kvm&m=144544706530484&w=2

I really don't like the idea of trying to migrate the MSI-X across from 
host to host while it is still active.  I really think Qemu shouldn't be 
moving this kind of data over in a migration.

I think that having the VF do a suspend/resume is the best way to go.  
Then it simplifies things as all you have to deal with is the dirty page 
tracking for the Rx DMA and you should be able to do this without making 
things too difficult.

- Alex
