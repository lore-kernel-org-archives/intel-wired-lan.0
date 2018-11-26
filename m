From: Josh Elsasser <jelsasser@appneta.com>
Date: Mon, 26 Nov 2018 09:54:28 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <87efb92z5w.fsf@miraculix.mork.no>
References: <20181124205801.67828-1-jelsasser@appneta.com>
 <87efb92z5w.fsf@miraculix.mork.no>
Message-ID: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bj?rn Mork <bjorn@mork.no> wrote:

> Not that it matters much I guess, but I think LX SFPs were unsupported
> at that time. The LX support appears to have been added under the radar
> while refactoring ixgbe_setup_sfp_modules_X550em in commit e23f33367882
> ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+")

Looks like you?re right. Want me to respin with an additional ?Fixes? tag?

- Josh
