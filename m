From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 3 Apr 2017 16:48:46 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Allow disabling VFs when
 they are pre-existing
In-Reply-To: <1491066220.7454.72.camel@intel.com>
References: <20170401002603.29536.93262.stgit@mdrustad-mac04.local>
 <1491066220.7454.72.camel@intel.com>
Message-ID: <DA095D4F-D7E3-40BC-8381-E12541229104@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alex,

> On Apr 1, 2017, at 10:03 AM, Duyck, Alexander H <alexander.h.duyck@intel.com> wrote:
> 
> On Fri, 2017-03-31 at 17:26 -0700, Mark D Rustad wrote:
>> Right now if VFs existing when the driver is loaded, it is not
>> possible to destroy those VFs, even though messages from the driver
>> suggest doing that when trying to change the number. This change
>> permits the disabling of SR-IOV for the case when there are
>> pre-existing VFs.
>> 
>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> ---
>> Changes in V2:
>> - Remove unwanted content in the changelog message - sorry about that
>> ---
>> src/CORE/ixgbe_sriov.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/src/CORE/ixgbe_sriov.c b/src/CORE/ixgbe_sriov.c
>> index 9b7d05110fe9..231acf274a70 100644
>> --- a/src/CORE/ixgbe_sriov.c
>> +++ b/src/CORE/ixgbe_sriov.c
>> @@ -603,7 +603,7 @@ static int ixgbe_pci_sriov_disable(struct pci_dev *dev)
>> 	u32 current_flags = adapter->flags;
>> #endif
>> 
>> -	if (adapter->num_vfs == 0)
>> +	if (!adapter->num_vfs && !pci_num_vf(dev))
>> 		return -EINVAL;
>> 
>> 	err = ixgbe_disable_sriov(adapter);
> 
> So I assume this patch isn't meant for upstream at all since there
> isn't a CORE folder in the upstream kernel. Also this patch does't
> apply to any existing upstream tree.

Sigh. My blunder. Sorry about the noise. I typed the command to send it in the wrong window.

> On a side note it would probably be best to just drop this check
> entirely. Checking for adapter->num_vfs doesn't tell you anything other
> than the fact that memory is allocated for vfinfo.

Well, the code here seems to be trying to avoid disabling SR-IOV when it is not enabled. Is there any need to do that other than possibly more precise messaging?

> In the upstream driver one thing we should probably do is add a check
> against pci_num_vf() in ixgbe_disable_sriov instead of using
> "!(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)". That way we will try to
> disable SR-IOV if that is what we are actually trying to do instead of
> only if the driver had allocated memory for it.

I guess if the initialization path also set that bit when there were pre-existing VFs. That would provide a positive check for enablement as opposed to resource usage. Then that flag could be checked here I suppose. It would make the intent of the check here much clearer.

> However like I stated on the other patch it would probably be best to
> take a look at fm10k and borrow from that since I think what we really
> should be doing is attempting to resume with the same number of VFs
> that were previously enabled so the VFs can resume operation if the PF
> is reloaded with support for SR-IOV.

I have doubts about how feasible that is for ixgbe. I know enough to worry about that, but not enough to know that it isn't a worry. I worry that ixgbe may have too much state kept in its structures to be able to resume VFs safely.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170403/fe987d0a/attachment.asc>
