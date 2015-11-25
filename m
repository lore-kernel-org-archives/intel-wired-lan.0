From: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed, 25 Nov 2015 16:21:44 +0800
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <CAKgT0UcSrewenfM2YdVojHFFqfK2aVbBN5LH8=BFzc1p0f9hvQ@mail.gmail.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>	<5654722D.4010409@gmail.com>	<56552888.90108@intel.com>
 <CAKgT0UcSrewenfM2YdVojHFFqfK2aVbBN5LH8=BFzc1p0f9hvQ@mail.gmail.com>
Message-ID: <56556F98.5060507@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015?11?25? 13:30, Alexander Duyck wrote:
> No, what I am getting at is that you can't go around and modify the
> configuration space for every possible device out there.  This
> solution won't scale.


PCI config space regs are emulation by Qemu and so We can find the free
PCI config space regs for the faked PCI capability. Its position can be
not permanent.


>  If you instead moved the logic for notifying
> the device into a separate mechanism such as making it a part of the
> hot-plug logic then you only have to write the code once per OS in
> order to get the hot-plug capability to pause/resume the device.  What
> I am talking about is not full hot-plug, but rather to extend the
> existing hot-plug in Qemu and the Linux kernel to support a
> "pause/resume" functionality.  The PCI hot-plug specification calls
> out the option of implementing something like this, but we don't
> currently have support for it.
>

Could you elaborate the part of PCI hot-plug specification you mentioned?

My concern is whether it needs to change PCI spec or not.



> I just feel doing it through PCI hot-plug messages will scale much
> better as you could likely make use of the power management
> suspend/resume calls to take care of most of the needed implementation
> details.
> 
> - Alex
-- 
Best regards
Tianyu Lan
