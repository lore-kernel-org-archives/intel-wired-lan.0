From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:44:48 +0000
Subject: [Intel-wired-lan] [PATCH 3/9] ixgbevf: use length to determine
 if descriptor is done
In-Reply-To: <20171211183659.21524.88045.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183659.21524.88045.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EEDD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Emil Tantilov
> Sent: Monday, December 11, 2017 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/9] ixgbevf: use length to determine if
> descriptor is done
> 
> Based on:
> commit 7ec0116c9131 ("igb: Use length to determine if descriptor is done")
> 
> This change makes it so that we use the length of the packet instead of the
> DD status bit to determine if a new descriptor is ready to be processed.
> The obvious advantage is that it cuts down on reads as we don't really even
> need the DD bit if going from a 0 to a non-zero value on size is enough to
> inform us that the packet has been completed.
> 
> In addition we only reset the Rx descriptor length for descriptor zero when
> resetting a ring instead of having to do a memset with 0 over the entire
> ring. By doing this we can save some time on initialization.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

