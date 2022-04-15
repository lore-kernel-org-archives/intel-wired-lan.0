From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri, 15 Apr 2022 15:53:54 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <YlldsfrRJURXpp5d@boxer>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer> <YlldsfrRJURXpp5d@boxer>
Message-ID: <20220415135354.478687-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 15 Apr 2022 13:57:37 +0200

> On Fri, Apr 15, 2022 at 01:55:10PM +0200, Maciej Fijalkowski wrote:
> > On Wed, Apr 13, 2022 at 09:22:59AM +0200, Ivan Vecera wrote:
> > > Previous patch labelled "ice: Fix incorrect locking in
> > > ice_vc_process_vf_msg()"  fixed an issue with ignored messages
> > 
> > tiny tiny nit: double space after "
> > Also, has mentioned patch landed onto some tree so that we could provide
> > SHA-1 of it? If not, then maybe squashing this one with the mentioned one
> > would make sense?
> 
> Again, Brett's Intel address is bouncing, so:
> CC: Brett Creeley <brett@pensando.io>

Cc: Jacob Keller <jacob.e.keller@intel.com>

> 
> > 
> > > sent by VF driver but a small race window still left.

--- 8< ---

> > > -- 
> > > 2.35.1

Al
