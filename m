From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jul 2020 15:37:29 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] bonding: deal with xfrm
 state in all modes and add more error-checking
In-Reply-To: <20200708174631.15286-1-jarod@redhat.com>
References: <20200708174631.15286-1-jarod@redhat.com>
Message-ID: <20200708.153729.1570943134510183928.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jarod Wilson <jarod@redhat.com>
Date: Wed,  8 Jul 2020 13:46:31 -0400

> It's possible that device removal happens when the bond is in non-AB mode,
> and addition happens in AB mode, so bond_ipsec_del_sa() never gets called,
> which leaves security associations in an odd state if bond_ipsec_add_sa()
> then gets called after switching the bond into AB. Just call add and
> delete universally for all modes to keep things consistent.
> 
> However, it's also possible that this code gets called when the system is
> shutting down, and the xfrm subsystem has already been disconnected from
> the bond device, so we need to do some error-checking and bail, lest we
> hit a null ptr deref.
> 
> Fixes: a3b658cfb664 ("bonding: allow xfrm offload setup post-module-load")
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Applied, thanks Jarod.
