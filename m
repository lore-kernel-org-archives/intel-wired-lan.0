From: robert_s@gmx.net <robert_s@gmx.net>
Date: Tue, 26 Oct 2021 02:22:25 +0200
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Allow disabling NBASE-T
 suppression hack
In-Reply-To: <3ec21b215c88604e4e8475240be9d11f5abdb1e5.camel@intel.com>
References: <trinity-58e35e17-0323-4cde-bbed-1582c3520822-1634891867291@3c-app-gmx-bap44>
 <9f4603a5-7811-c653-951b-777070f7ce54@molgen.mpg.de>
 <392a6fe-e920-31b-42dc-a214e311233c@twofifty.com>
 <trinity-7ec48fc1-b568-49df-8837-218ec2c431c4-1634940936574@3c-app-gmx-bs49>
 <3ec21b215c88604e4e8475240be9d11f5abdb1e5.camel@intel.com>
Message-ID: <trinity-71d0a350-a27f-4ed0-9c08-53a1f3f6b42a-1635207745364@3c-app-gmx-bap12>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From:?"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>

> The community has changed their acceptance of private module
> parameters. While previous ones were accepted, they are not accepting
> any new additions.

A reference would have been helpful, but I eventually found it myself:

https://lore.kernel.org/netdev/20170324.144017.1545614773504954414.davem at davemloft.net/

After short discussion on netdev, I realized that the module parameter is
indeed not needed, so I'm revoking this patch.

Instead, I'll submit another patch that only adds the missing documentation
about NBASE-T support and how to enable it. That should be acceptable.

Best regards,
-Robert Schlabbach
