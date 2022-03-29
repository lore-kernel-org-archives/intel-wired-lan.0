From: Ivan Vecera <ivecera@redhat.com>
Date: Tue, 29 Mar 2022 19:55:22 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Fix logic of getting XSK
 pool associated with Tx queue
In-Reply-To: <YkL0wfgyCq5s8vdu@boxer>
References: <20220329102752.1481125-1-ivecera@redhat.com>
 <YkL0wfgyCq5s8vdu@boxer>
Message-ID: <20220329195522.63d332fb@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 29 Mar 2022 14:00:01 +0200
Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:

> Thanks for this fix! I did exactly the same patch yesterday and it's
> already applied to bpf tree:
> 
> https://lore.kernel.org/bpf/20220328142123.170157-5-maciej.fijalkowski at intel.com/T/#u
> 
> Maciej

Thanks for info... Nice human race condition ;-)

I.

