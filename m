From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Date: Sun, 25 Nov 2018 12:07:39 +0100
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <20181124205801.67828-1-jelsasser@appneta.com> (Josh Elsasser's
 message of "Sat, 24 Nov 2018 12:57:33 -0800")
References: <20181124205801.67828-1-jelsasser@appneta.com>
Message-ID: <87efb92z5w.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Josh Elsasser <jelsasser@appneta.com> writes:

> Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")

Not that it matters much I guess, but I think LX SFPs were unsupported
at that time. The LX support appears to have been added under the radar
while refactoring ixgbe_setup_sfp_modules_X550em in commit e23f33367882
("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+")


Bj?rn
