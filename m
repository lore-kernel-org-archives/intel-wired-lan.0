From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 13 Jun 2016 12:16:42 -0700
Subject: [Intel-wired-lan] [net-next PATCH 04/15] bnxt: Replace
	ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <CAEh+42jyXOytgidZN4MNBoPaKL-xoQDXptFqnbhWrMGc5=8z=w@mail.gmail.com>
References: <20160613173750.15186.24381.stgit@localhost.localdomain>
 <20160613174822.15186.55819.stgit@localhost.localdomain>
 <CAEh+42jyXOytgidZN4MNBoPaKL-xoQDXptFqnbhWrMGc5=8z=w@mail.gmail.com>
Message-ID: <CACKFLi=opqb393SGEKLgN-cvQn7xL8kYVr+=MhW7SO41-xPJZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 13, 2016 at 11:41 AM, Jesse Gross <jesse@kernel.org> wrote:
> On Mon, Jun 13, 2016 at 10:48 AM, Alexander Duyck <aduyck@mirantis.com> wrote:
>> This change replaces the network device operations for adding or removing a
>> VXLAN port with operations that are more generically defined to be used for
>> any UDP offload port but provide a type.  As such by just adding a line to
>> verify that the offload type if VXLAN we can maintain the same
>> functionality.
>>
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>
> It looks like bnxt actually has a hardcoded offload of the Geneve port
> rather than using the registration (maybe it predated it?).

It's not hardcoded.  The driver code just predated the ndo geneve calls.

>  It would
> be nice to incorporate that into your unified handler as well.
>
> I think you could actually just kill all of these
> CONFIG_VXLAN/CONFIG_GENEVE checks (across all the drivers, not just
> this one). They shouldn't be necessary any more now that there's no
> longer strong linkage to the tunnel drivers.

Agreed.
