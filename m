From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 7 Aug 2019 16:51:52 +0200
Subject: [Intel-wired-lan] [PATCH v4] e1000e: PCIm function state support
In-Reply-To: <bc5fbdcb-6afe-dac0-b498-c5e26d539d6d@intel.com>
References: <20190804074026.25198-1-vitaly.lifshits@intel.com>
 <8829b684-518d-2233-d618-4f1367c2dbbd@molgen.mpg.de>
 <bc5fbdcb-6afe-dac0-b498-c5e26d539d6d@intel.com>
Message-ID: <a5a0b21c-5df3-809b-fc7a-022f2432676c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Vitaly,


On 07.08.19 09:47, Lifshits, Vitaly wrote:

> Thank you again for your comments.
> I sent a new version for my patch (V5).

Thank you very much for incorporating them.

> On 8/4/2019 16:44, Paul Menzel wrote:

>> On 04.08.19 09:40, Vitaly Lifshits wrote:

[?]

>>> +??????????? pcim_state = er32(STATUS);
>>> +??????????? while (pcim_state & E1000_STATUS_PCIM_STATE) {
>>> +??????????????? if (tries++ == PCIM_DMOFF_EXIT_TIMEOUT) {

By the way, can?t there be the unit appended to the macro name
`PCIM_DMOFF_EXIT_TIMEOUT`?

>>> +??????????????????? e_dbg("Error in exiting dmoff\n");
>>> +??????????????????? e_err("PCIm DMoff timeout expired\n");

It?s not a hold-up, but why do you print two messages? I?d just print the
error message.

    e_err("Failed to exit PCIm DMoff: Time-out (%i iterations) expired", PCIM_DMOFF_EXIT_TIMEOUT);

Or: e_err("Exiting PCIm DMoff timed out after %i iterations.", PCIM_DMOFF_EXIT_TIMEOUT);

>>> +??????????????????? break;
>>> +??????????????? }
>>> +??????????????? usleep_range(10000, 20000);
>>> +??????????????? pcim_state = er32(STATUS);
>>> +
>>> +??????????????? /* If MAC entered DMoff state, PHY reset is
>>> +???????????????? * needed after exiting it
>>> +???????????????? */
>>> +??????????????? if (!(pcim_state & E1000_STATUS_PCIM_STATE))
>>> +??????????????????? e1000_phy_hw_reset(&adapter->hw);
>>
>> I still believe, the if statement should be moved *outside* the loop.
> 
> The if statement has to stay in the loop since the PHY reset is
> needed only if the MAC entered DMoff state.

Thank you. Now I finally saw it. It?s about, when the loop is never
entered. I associated a while loop in my head normally with the assumption,
that the condition is true in the beginning.

For the record, the code below is more intuitive for me.

```
if (pcim_state & E1000_STATUS_PCIM_STATE) {
/* MAC in DMoff state */
	do {
		if (tries++ == PCIM_DMOFF_EXIT_TIMEOUT) {
			e_dbg("Error in exiting dmoff\n");
			e_err("PCIm DMoff timeout expired\n");
			break;
		}
		usleep_range(10000, 20000);
		pcim_state = er32(STATUS);
	} while (pcim_state & E1000_STATUS_PCIM_STATE);

	e1000_phy_hw_reset(&adapter->hw);
}
```

>>> +??????????? }
>>> +
>>> ????????????? /* update snapshot of PHY registers on LSC */
>>> ????????????? e1000_phy_read_status(adapter);
>>> ????????????? mac->ops.get_link_up_info(&adapter->hw,

Anyway, I do not want to hold up anything.


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190807/6dc6dc31/attachment-0001.p7s>
