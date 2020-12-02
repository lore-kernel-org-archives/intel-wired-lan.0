From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 2 Dec 2020 11:06:40 -0800
Subject: [Intel-wired-lan] [PATCH v2 0/5] Improve s0ix flows for systems
 i219LM
In-Reply-To: <20201202161748.128938-1-mario.limonciello@dell.com>
References: <20201202161748.128938-1-mario.limonciello@dell.com>
Message-ID: <20201202110640.27269583@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed,  2 Dec 2020 10:17:43 -0600 Mario Limonciello wrote:
> commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
> disabled s0ix flows for systems that have various incarnations of the
> i219-LM ethernet controller.  This was done because of some regressions
> caused by an earlier
> commit 632fbd5eb5b0e ("e1000e: fix S0ix flows for cable connected case")
> with i219-LM controller.
> 
> Performing suspend to idle with these ethernet controllers requires a properly
> configured system.  To make enabling such systems easier, this patch
> series allows turning on using ethtool.
> 
> The flows have also been confirmed to be configured correctly on Dell's Latitude
> and Precision CML systems containing the i219-LM controller, when the kernel also
> contains the fix for s0i3.2 entry previously submitted here:
> https://marc.info/?l=linux-netdev&m=160677194809564&w=2
> 
> Patches 3 and 4 will turn the behavior on by default for Dell's CML systems.
> Patch 5 allows accessing the value of the flags via ethtool to tell if the
> heuristics have turned on s0ix flows, as well as for development purposes
> to determine if a system should be added to the heuristics list.

I don't see PCI or Bjorn Helgaas CCed.

You can drop linux-kernel tho.
