From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Tue, 31 Mar 2020 14:12:12 -0700
Subject: [Intel-wired-lan] [PATCH 05/12] igc: Refactor
 igc_rar_set_index()
In-Reply-To: <bddc690a-8d29-fb44-8b26-67c3cf9fdf80@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-6-andre.guedes@intel.com>
 <bddc690a-8d29-fb44-8b26-67c3cf9fdf80@intel.com>
Message-ID: <158568913295.84366.14895161973219728060@latran-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Neftin, Sasha (2020-03-31 04:22:12)
> > -/**
> > - * igc_rar_set_index - Sync RAL[index] and RAH[index] registers with MAC table
> > - * @adapter: address of board private structure
> > - * @index: Index of the RAR entry which need to be synced with MAC table
> > +/* Set MAC address filter in hardware.
> Small correction to be consistently. Please, keep /** line above method 
> declaration line.

Yes, I can fix that. I thought we utilized kernel-doc style comments only for
APIs, not local helper functions like this.

@Jeff, what works better for your workflow, I send a v2 in-reply-to this patch
or I send a v2 of the whole patchset?

- Andre
