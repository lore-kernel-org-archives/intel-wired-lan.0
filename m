From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 22 Jan 2016 13:36:12 -0800
Subject: [Intel-wired-lan] [next PATCH v2 15/15] i40evf: Update feature
 flags to reflect newly enabled features
In-Reply-To: <56A29EB1.8030107@intel.com>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
 <20160122002829.18278.45002.stgit@localhost.localdomain>
 <56A29EB1.8030107@intel.com>
Message-ID: <CAKgT0Uf6FjGwxA_=4f7cwPXw0PPQiN25j2WJcqHEpO2DOA1p_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 22, 2016 at 1:27 PM, Singhai, Anjali
<anjali.singhai@intel.com> wrote:
> We haven't SVed any of the tunnel offloads in the VF, I am assuming you
> tried this.

Yes, I've been testing it with an XL710.  For the most part if it is
PF or VF it shouldn't really matter.  The descriptor format is all the
same for the Tx rings so the offload functionality all works the same.
