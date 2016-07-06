From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 6 Jul 2016 23:00:51 +0000
Subject: [Intel-wired-lan] [PATCH] (resend) ixgbe: always initialize
	setup_fc
In-Reply-To: <CAE2NFgXe4uPT1WDVzSq_rr54XA7xDNuedoBgHdtd2_WekNQZ+A@mail.gmail.com>
References: <CAE2NFgXe4uPT1WDVzSq_rr54XA7xDNuedoBgHdtd2_WekNQZ+A@mail.gmail.com>
Message-ID: <038AE347-E85C-4738-BC91-C8C16AE88620@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Patrick McLean <patrickm@gaikai.com> wrote:

> Gmail mangled my first message, sorry about that. Second attempt.
>
> In ixgbe_init_mac_link_ops_X550em, the code has a special case for
> backplane media type, but does not fall through to the default case,
> so the setup_fc never gets initialized. This causes a panic when it
> later tries to set up the card, and the kernel dereferences the null
> pointer.
>
> This patch lets the the function fall through, which initialized
> setup_fc properly.

I don't think that this is the right fix. My memory is that fc autoneg is  
not supported in that configuration, so setup_fc is intended to be NULL. I  
think it is the reference that needs to have a check added.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160706/b46cb91d/attachment.asc>
