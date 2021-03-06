%                               -*- Mode: Rd -*- 
% learn.Rd --- 
% Author          : Claus Dethlefsen
% Created On      : Sat May 25 23:02:26 2002
% Last Modified By: Claus Dethlefsen
% Last Modified On: Mon Jan 05 14:37:16 2009
% Update Count    : 88
% Status          : Unknown, Use with caution!
% 

\name{learn}
\alias{learn}
\encoding{latin1}
%- Also NEED an `\alias' for EACH other topic documented here.

\title{Estimation of parameters in the local probability
distributions}

\description{Updates the distributions of the parameters in the network,
  based on a prior network and data. Also, the network score is calculated.
}

\usage{
learn (nw, df, prior=jointprior(nw),
               nodelist=1:size(nw),
               trylist=vector("list",size(nw)),
               timetrace=FALSE) 

}

%- maybe also `usage' for other objects documented here.
\arguments{
  \item{nw}{an object of class \code{\link{network}}.}
  \item{df}{a data frame used for learning the network, see
    \code{\link{network}}.} 
  \item{prior}{a list containing parameter priors, generated by
    \code{\link{jointprior}}.} 
  \item{nodelist}{a numeric vector of indices of nodes to be learned.}
  \item{trylist}{a list used internally for reusing learning of nodes,
    see \code{\link{maketrylist}}.} 
  \item{timetrace}{a logical. If \code{TRUE}, prints some timing
    information on the screen.} 
}

\details{
  The procedure \code{learn} determines the master prior, local parameter
  priors and local parameter posteriors, see Bottcher (2001). It may be called on all nodes
  (default) or just a single node. 
  
  From the joint prior distribution, the marginal distribution of
  all parameters in the family consisting of the node and its parents
  can be determined. This is the master prior, see
  \code{\link{localmaster}}.

  The local parameter priors are now determined by conditioning in
  the master prior distribution, see
  \code{\link{conditional}}. The hyperparameters associated with the
  local parameter prior distribution is attached to each node in the
  property \code{condprior}.

  Finally, the local parameter posterior distributions are calculated (see
  \code{\link{post}}) and attached to each node in the property
  \code{condposterior}. 
  
  A so-called trylist is maintained to speedup the learning process. The
  trylist consists of a list of
  matrices for each node. The matrix for a given node holds previously
  evaluated parent configurations and the corresponding log-likelihood
  contribution. If a node with a certain parent
  configuration needs to be learned, it is checked, whether the node has
  already been learned. The previously learned nodes are given as input
  in the trylist parameter and is updated in the learning procedure. 

  When one or more nodes in a network have been learned, the network
  score is updated and attached to the network in the property
  \code{score}.  

  The learning procedure is called from various functions using the
  principle, that networks should always be updated with their
  score. Thus, e.g.\ \code{\link{drawnetwork}} keeps the network updated
  when the graph is altered.

}

\seealso{\code{\link{networkfamily}},
\code{\link{jointprior}},
\code{\link{maketrylist}},
\code{\link{network}}
}

\value{A list with two elements that may be accessed using
  \code{\link{getnetwork}} and \code{\link{gettrylist}}. The elements are
  \item{nw}{an object of class \code{\link{network}}, with the
    \code{condposterior} properties updated for 
    the nodes. Also, the property \code{score} is updated and contains
    the network score. The contribution to the network score for each
    node is contained in the property \code{loglik} for each node.}
  \item{trylist}{an updated list used internally for reusing learning
    of nodes, see \code{\link{maketrylist}}.}
}

\references{
 Bottcher, S.G. (2001). Learning Bayesian Networks with Mixed Variables, Artificial Intelligence and Statistics 2001, Morgan Kaufmann, San Francisco, CA, USA, 149-156.

}

\author{
  Susanne Gammelgaard Bottcher, \cr
  Claus Dethlefsen \email{rpackage.deal@gmail.com}.
}


\examples{
data(rats)
fit       <- network(rats)
fit.prior <- jointprior(fit,12)
fit.learn <- learn(fit,rats,fit.prior,timetrace=TRUE)
fit.nw    <- getnetwork(fit.learn)
fit.learn2<- learn(fit,rats,fit.prior,trylist=gettrylist(fit.learn),timetrace=TRUE)
}

\keyword{iplot}
