From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 25 Apr 2016 22:01:59 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use msleep for long delays
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2699@ORSMSX104.amr.corp.intel.com>
References: <1460838941-1251989-1-git-send-email-arnd@arndb.de>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2699@ORSMSX104.amr.corp.intel.com>
Message-ID: <B67B33C6-1559-4227-8A27-937FA51B22C3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

AndrewX <andrewx.bowers@intel.com> wrote:

>> -----Original Message-----
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>> Behalf Of Arnd Bergmann
>> Sent: Saturday, April 16, 2016 1:35 PM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel at vger.kernel.org; intel-
>> wired-lan at lists.osuosl.org; netdev at vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH] ixgbe: use msleep for long delays
>>
>> The newly added x550em_a support causes a link failure on ARM because of
>> an overly long time passed into udelay():
>>
>> ERROR: "__bad_udelay" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko]
>> undefined!
>>
>> There are multiple variants of the ixgbe_acquire_swfw_sync_*() function,
>> and the other ones all use msleep(), so we can safely assume that all  
>> callers
>> are allowed to sleep, which makes msleep() a better replacement than
>> mdelay().
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> Able to cross-compile driver for ARM architecture without sleep errors or  
> warnings from compiler
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Was this functionally tested? I am concerned that we can get sleeping while  
atomic errors from ethtool operations with this in place. Compiling  
successfully does not test that.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160425/2e752888/attachment.asc>
