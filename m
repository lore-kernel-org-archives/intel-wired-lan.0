From: Saleem, Shiraz <shiraz.saleem@intel.com>
Date: Mon, 12 Mar 2018 22:55:45 +0000
Subject: [Intel-wired-lan] [next PATCH S88 3/8] i40e: Close client on
 suspend and restore client MSIx on resume
In-Reply-To: <20180312140022.59580-3-alice.michael@intel.com>
References: <20180312140022.59580-1-alice.michael@intel.com>
 <20180312140022.59580-3-alice.michael@intel.com>
Message-ID: <9DD61F30A802C4429A01CA4200E302A789F64409@fmsmsx116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>Subject: [next PATCH S88 3/8] i40e: Close client on suspend and restore client
>MSIx on resume
>
>From: Shiraz Saleem <shiraz.saleem@intel.com>
>
>During suspend client MSIx vectors are freed while they are still in use causing a
>crash on entering S3.
>
>Fix this calling client close before freeing up its MSIx vectors.
>Also update the client MSIx vectors on resume before client open is called.
>
>Fixes commit b980c0634fe5 ("i40e: shutdown all IRQs and disable MSI-X when
>suspended")
>
>Reported-by: Stefan Assmann <sassmann@redhat.com>
>Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>---

ACK. Thank you Alice!
