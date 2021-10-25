From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 25 Oct 2021 17:14:09 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Allow disabling NBASE-T
 suppression hack
In-Reply-To: <trinity-7ec48fc1-b568-49df-8837-218ec2c431c4-1634940936574@3c-app-gmx-bs49>
References: <trinity-58e35e17-0323-4cde-bbed-1582c3520822-1634891867291@3c-app-gmx-bap44>
 <9f4603a5-7811-c653-951b-777070f7ce54@molgen.mpg.de>
 <392a6fe-e920-31b-42dc-a214e311233c@twofifty.com>
 <trinity-7ec48fc1-b568-49df-8837-218ec2c431c4-1634940936574@3c-app-gmx-bs49>
Message-ID: <3ec21b215c88604e4e8475240be9d11f5abdb1e5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-10-23 at 00:15 +0200, Robert Schlabbach wrote:
> On Fri, 22 Oct 2021, Hisashi T Fujinaka wrote:
> 
> > We're not likely to accept this patch because it adds a private
> > module
> > parameter and upstream will not accept it.
> 
> I don't understand. The module already has 3 parameters, so why is a
> 4th not acceptable?

The community has changed their acceptance of private module
parameters. While previous ones were accepted, they are not accepting
any new additions.

Thanks,
Tony

