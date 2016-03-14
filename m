From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 14 Mar 2016 21:11:15 +0000
Subject: [Intel-wired-lan] [PATCH V2 5/5] ixgbe: Take manageability
 semaphore for firmware commands
In-Reply-To: <20160314180602.8397.1350.stgit@mdrustad-wks.jf.intel.com>
References: <20160314180316.8397.65394.stgit@mdrustad-wks.jf.intel.com>
 <20160314180602.8397.1350.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <8511E145-FC8F-483B-9ED1-276997F3DB44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Mark D Rustad <mark.d.rustad@intel.com> wrote:

> We need to take the manageability semaphore when issuing firmware
> commands to avoid problems. With this in place, the semaphore is
> no longer taken in the ixgbe_set_fw_drv_ver_generic function, since
> it will now always be taken by the ixgbe_host_interface_command
> function.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   30 +++++++++++++++--------
>  1 file changed, 19 insertions(+), 11 deletions(-)

<snip>

I would like this patch considered for -net since it is a spec violation on  
all X550 devices and can result in NVM checksum errors, bad MAC addresses  
or other unpredictable behavior. It could also be usefully backported to  
any version that includes the ixgbe_x550.c file.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160314/ad254f96/attachment.asc>
