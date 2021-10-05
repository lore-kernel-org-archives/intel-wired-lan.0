From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Tue, 5 Oct 2021 11:20:28 -0700 (PDT)
Subject: [Intel-wired-lan] Intel I350 regression 5.10 -> 5.14 ("The NVM
 Checksum Is Not Valid") [8086:1521]
In-Reply-To: <b56c4c30-d393-96fb-182c-726a60a39eed@molgen.mpg.de>
References: <1823864.tdWV9SEqCh@kailua>
 <20211004074814.5900791a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7064659e-fe97-f222-5176-844569fb5281@twofifty.com>
 <4111f2b7-cbac-3451-593f-a154aca65263@intel.com>
 <b56c4c30-d393-96fb-182c-726a60a39eed@molgen.mpg.de>
Message-ID: <3db85012-3e16-ca2d-5742-d9ecd45eba7e@twofifty.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 5 Oct 2021, Paul Menzel wrote:

> Linux has a no-regression policy, meaning when userspace/hardware with an 
> older Linux kernel worked than it *has to* work with a new version too. So 
> besides fixing the firmware/system, it?s as important to find the commit 
> introducing the regression and fix it.

I think you're looking at the wrong driver. igb is fairly stable and we
haven't been poking at it much. Most of the changes have been from the
community. Sasha is commiting to igc, not igb.

In any case, we don't have the hardware (motherboard or NIC) and any
bisection will have to be done by the issue submitter.

Todd Fujinaka todd.fujinaka at intel.com
