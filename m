From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Mon, 11 Jul 2016 18:41:40 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: always initialize setup_fc
In-Reply-To: <CAE2NFgXEYU0mJDs638JYzykUSz4PCme6kecXVjWesH=0ySxZVQ@mail.gmail.com>
References: <CAE2NFgXEYU0mJDs638JYzykUSz4PCme6kecXVjWesH=0ySxZVQ@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D6799250670DA6@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Patrick McLean
>Sent: Friday, July 01, 2016 6:31 PM
>To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH] ixgbe: always initialize setup_fc
>
>In ixgbe_init_mac_link_ops_X550em, the code has a special case for
>backplane media type, but does not fall through to the default case, so the
>setup_fc never gets initialized. This causes a panic when it later tries to
>set up the card, and the kernel dereferences the null pointer.
>
>This patch lets the the function fall through, which initialized setup_fc
>properly.

Why are you resending this patch? I have already submitted a patch to handle this properly:
http://patchwork.ozlabs.org/patch/646228/

Thanks,
Emil 
 

