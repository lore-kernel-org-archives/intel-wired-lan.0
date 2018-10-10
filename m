From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Oct 2018 12:43:45 -0700
Subject: [Intel-wired-lan] i40e: Fix permission check for VF MAC filters
In-Reply-To: <415A193C-5F84-4CED-B2F6-2FD58B88C76F@att.com>
References: <E8B8AE1B-2618-4C58-A144-06BB8F2537D6@att.com>
 <415A193C-5F84-4CED-B2F6-2FD58B88C76F@att.com>
Message-ID: <a8663e5c9deea6f725f4609f57437f4e91be6e18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-10-08 at 20:57 +0000, MEHAN, MUNISH wrote:
> Hi Jeff,
>  
>   I am testing bonding of vfs in a vms using i40e version - 2.4.18
> and vm is using i40evf version 3.5.6. When a vf is brought down and
> up inside vm I see the following on the host.  After this the vm bond
> interface don?t work as desired. We cannot enable trust mode due to
> security in multi-tenant env. I see you have fixed some related code 
> https://github.com/torvalds/linux/commit/03ce7b1d23498c97bc530a1296852af0cdd2fe77#diff-932c10dedc2420dd5a100486efea9bff
>  , do you know if this addresses this issue.

Well the patch you referred to was to address the link state in the VF,
to ensure that it properly reflects the current link state.  While this
may have some bearing on what you are experiencing, it does not seem
likely that it would "fix" your issue.

If you could try the latest kernel in David Miller's net-next tree, to
see if the issues persists, that would be useful information in trying
to debug this issue.

Also, please CC intel-wired-lan at lists.osuosl.org so that all of the
networking developers/engineers are able to review and weigh in on your
issue.

>  
> Host dmesg
>  
> [1040608.711702] i40e 0000:3b:00.0: VF is not trusted, switch the VF
> to trusted to add more functionality
> [1040608.721012] i40e 0000:3b:00.0: VF 30 failed opcode 10, retval:
> -1
>  
> VM dmesg
>  
> [ 2155.767125] i40evf 0000:00:05.0 ens5: NIC Link is Up 40 Gbps Full
> Duplex
> [ 2157.773884] i40evf 0000:00:05.0: Failed to add MAC filter, error
> I40E_ERR_NVM

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181010/68858829/attachment.asc>
