From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 30 Mar 2016 19:51:53 -0400
Subject: [Intel-wired-lan] [net PATCH v2] i40e/i40evf: Limit TSO to 7
 descriptors for payload instead of 8 per packet
In-Reply-To: <20160330231116.12643.59554.stgit@localhost.localdomain>
References: <20160330231116.12643.59554.stgit@localhost.localdomain>
Message-ID: <20160330235153.GM27540@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Yes, this fixes it for me too!

Tested-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

