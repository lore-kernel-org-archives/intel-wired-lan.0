From: Ivan Vecera <ivecera@redhat.com>
Date: Fri, 15 Apr 2022 18:38:45 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <YlldFriBVkKEgbBs@boxer>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer>
Message-ID: <20220415183845.51a326fe@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 15 Apr 2022 13:55:02 +0200
Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:

> On Wed, Apr 13, 2022 at 09:22:59AM +0200, Ivan Vecera wrote:
> > Previous patch labelled "ice: Fix incorrect locking in
> > ice_vc_process_vf_msg()"  fixed an issue with ignored messages  
> 
> tiny tiny nit: double space after "
> Also, has mentioned patch landed onto some tree so that we could provide
> SHA-1 of it? If not, then maybe squashing this one with the mentioned one
> would make sense?

Well, that commit were already tested and now it is present in Tony's queue
but not in upstream yet. It is not problem to squash together but the first
was about ignored VF messages and this one is about race and I didn't want
to make single patch with huge description that cover both issues.
But as I said, no problem to squash if needed.

Thx,
Ivan

