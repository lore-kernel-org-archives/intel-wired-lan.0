From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 13 Oct 2015 11:59:14 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: fix 32 bit build warnings
In-Reply-To: <57023416.17EujnXPCo@wuerfel>
References: <6607276.TY67sbLLqL@wuerfel>
 <1444717101.2870.16.camel@intel.com> <57023416.17EujnXPCo@wuerfel>
Message-ID: <1444762754.2870.30.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-10-13 at 13:37 +0200, Arnd Bergmann wrote:
> This is the majority of all build warnings we get on allmodconfig
> (both i386 and arm),
> so it would be really nice to have it fixed before 4.3. For all I can
> tell, the
> patch still applies on your branch too, but see below for the rebased
> version.
> 
> I also note that your branch is not part of linux-next, is that 
> intentional?

No, I assume it is because the linux-next maintainer has not picked up
my tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151013/c0a35e72/attachment.asc>
